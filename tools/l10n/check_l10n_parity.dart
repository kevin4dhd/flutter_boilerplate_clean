import 'dart:convert';
import 'dart:io';

/// Checks that all ARB locale files under [l10nDir]
/// 1) have the same key set as the reference file [referenceArbFileName],
/// 2) have the same key ORDER as the reference, and
/// 3) keys follow lowerCamelCase (exception: "continue_").
///
/// Usage (from repo root):
///   dart tools/l10n/check_l10n_parity.dart
Future<void> main(List<String> args) async {
  const String l10nDir = 'resources/lib/src/l10n';
  const String referenceArbFileName = 'intl_en.arb';
  final bool shouldFix = args.contains('--fix');

  final Directory dir = Directory(l10nDir);
  if (!await dir.exists()) {
    stderr.writeln('l10n directory not found: $l10nDir');
    exit(2);
  }

  final File referenceFile = File('${dir.path}/$referenceArbFileName');
  if (!await referenceFile.exists()) {
    stderr.writeln('Reference ARB file not found: ${referenceFile.path}');
    exit(2);
  }

  Map<String, dynamic> readJson(File file) {
    final content = file.readAsStringSync();
    return json.decode(content) as Map<String, dynamic>;
  }

  List<String> extractMessageKeysInOrder(Map<String, dynamic> jsonMap) {
    final keys = <String>[];
    for (final entry in jsonMap.entries) {
      final key = entry.key;
      final value = entry.value;
      if (key == '@@locale') {
        continue;
      }
      if (key.startsWith('@')) {
        continue;
      }
      if (value is! String) {
        continue;
      }
      keys.add(key);
    }
    return keys;
  }

  bool isLowerCamelCase(String key) {
    if (key == 'continue_') {
      return true; // allowed special-case
    }
    // lowerCamelCase: starts with lowercase letter, contains only letters/digits,
    // and has no underscores. Single-word lowercase also allowed.
    final regExp = RegExp(r'^[a-z][a-z0-9]*([A-Z][a-z0-9]*)*$');
    return regExp.hasMatch(key);
  }

  final Map<String, dynamic> referenceJson = readJson(referenceFile);
  final List<String> referenceKeysOrdered =
      extractMessageKeysInOrder(referenceJson);
  final Set<String> referenceKeys = referenceKeysOrdered.toSet();

  if (referenceKeys.isEmpty) {
    stderr.writeln(
        'No message keys found in reference file: ${referenceFile.path}');
    exit(2);
  }

  final List<FileSystemEntity> entities = dir.listSync();
  final List<File> arbFiles = entities
      .whereType<File>()
      .where((f) => f.path.endsWith('.arb'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  bool hasDiscrepancy = false;

  for (final File file in arbFiles) {
    if (file.path.endsWith(referenceArbFileName)) {
      continue;
    }

    final localeJson = readJson(file);
    final localeKeysOrdered = extractMessageKeysInOrder(localeJson);
    final localeKeys = localeKeysOrdered.toSet();

    final missingInLocale = referenceKeys.difference(localeKeys);
    final extraInLocale = localeKeys.difference(referenceKeys);

    // Check key format (lowerCamelCase)
    final badCaseKeys =
        localeKeysOrdered.where((k) => !isLowerCamelCase(k)).toList();

    // Check order parity
    bool orderMatches = true;
    int firstMismatchIndex = -1;
    if (missingInLocale.isEmpty && extraInLocale.isEmpty) {
      // compare index-by-index with reference order
      for (int i = 0; i < referenceKeysOrdered.length; i++) {
        if (i >= localeKeysOrdered.length ||
            localeKeysOrdered[i] != referenceKeysOrdered[i]) {
          orderMatches = false;
          firstMismatchIndex = i;
          break;
        }
      }
    } else {
      orderMatches = false;
    }

    // Auto-fix order if requested and no key set discrepancy or bad case keys
    if (shouldFix &&
        missingInLocale.isEmpty &&
        extraInLocale.isEmpty &&
        !orderMatches &&
        badCaseKeys.isEmpty) {
      // rebuild JSON with keys in reference order, preserving @@locale and @metadata
      final Map<String, dynamic> rebuilt = <String, dynamic>{};
      // keep @@locale at top if present
      if (localeJson.containsKey('@@locale')) {
        rebuilt['@@locale'] = localeJson['@@locale'];
      }
      for (final key in referenceKeysOrdered) {
        if (localeJson.containsKey(key)) {
          rebuilt[key] = localeJson[key];
        }
        final metaKey = '@$key';
        if (localeJson.containsKey(metaKey)) {
          rebuilt[metaKey] = localeJson[metaKey];
        }
      }
      const encoder = JsonEncoder.withIndent('  ');
      file.writeAsStringSync('${encoder.convert(rebuilt)}\n');
      // refresh structures for re-check after fix
      final fixedJson = readJson(file);
      final fixedKeysOrdered = extractMessageKeysInOrder(fixedJson);
      orderMatches = listEquals(referenceKeysOrdered, fixedKeysOrdered);
      firstMismatchIndex = orderMatches ? -1 : firstMismatchIndex;
    }

    if (missingInLocale.isEmpty &&
        extraInLocale.isEmpty &&
        orderMatches &&
        badCaseKeys.isEmpty) {
      stdout.writeln('[OK] ${file.path} parity with $referenceArbFileName');
      continue;
    }

    hasDiscrepancy = true;
    stdout.writeln('[MISMATCH] ${file.path}');
    if (missingInLocale.isNotEmpty) {
      stdout.writeln(
          '  - Missing keys (${missingInLocale.length}): ${missingInLocale.toList()..sort()}');
    }
    if (extraInLocale.isNotEmpty) {
      stdout.writeln(
          '  - Extra keys (${extraInLocale.length}): ${extraInLocale.toList()..sort()}');
    }
    if (!orderMatches) {
      stdout.writeln(
          '  - Order mismatch: keys must appear in the same order as $referenceArbFileName');
      stdout.writeln(
          '    Reference order (first 10): ${referenceKeysOrdered.take(10).toList()}');
      stdout.writeln(
          '    This file order (first 10): ${localeKeysOrdered.take(10).toList()}');
      if (firstMismatchIndex >= 0) {
        stdout.writeln(
            '    First mismatch at index $firstMismatchIndex: expected "${referenceKeysOrdered[firstMismatchIndex]}", got "${localeKeysOrdered[firstMismatchIndex]}"');
      }
    }
    if (badCaseKeys.isNotEmpty) {
      stdout.writeln(
          '  - Bad key case (${badCaseKeys.length}): ${badCaseKeys..sort()}');
      stdout.writeln(
          '    Keys must be lowerCamelCase. Allowed exception: "continue_"');
    }
  }

  if (hasDiscrepancy) {
    stderr.writeln(
        'L10n parity check failed. Please align ARB keys with $referenceArbFileName.');
    exit(1);
  }

  stdout.writeln('All ARB files are in parity with $referenceArbFileName.');
}

// Simple list equality check without importing collection package.
bool listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) {
    return true;
  }
  if (a.length != b.length) {
    return false;
  }
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}
