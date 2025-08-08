import 'package:flutter_test/flutter_test.dart';
import 'package:shared/shared.dart';

void main() {
  // Función auxiliar para generar dinámicamente las listas de WordTuple
  List<WordTuple> _generateWordTuples(int count, {int start = 1}) {
    return List.generate(
      count,
      (i) => WordTuple(index: start + i, word: 'word${start + i}'),
    );
  }

  group('SecretPhraseUtils', () {
    // --- Nuevo test para el método generate() ---
    group('generate', () {
      test('should generate a Mnemonic with 12 words', () {
        final mnemonic = SecretPhraseUtils.generate();
        expect(mnemonic, isNotNull);
        expect(mnemonic.words.length, 12);
      });
    });

    group('areSelectedWordsValid', () {
      // Caso positivo: las listas tienen la longitud correcta y todas las palabras son válidas
      test(
          'should return true when lists have correct length and words are equivalent',
          () {
        final selectedWords = _generateWordTuples(UiConstants.wordsToVerify);
        final randomIndexes = _generateWordTuples(UiConstants.wordsToVerify);

        final result = SecretPhraseUtils.areSelectedWordsValid(
            selectedWords, randomIndexes);

        expect(result, isTrue);
      });

      // Caso positivo: la equivalencia es "suave" (índice o palabra)
      test(
          'should return true when equivalence is based on either word or index',
          () {
        final selectedWords = _generateWordTuples(UiConstants.wordsToVerify);
        final randomIndexes = [
          WordTuple(index: 1, word: 'someOtherWord'), // Mismo índice
          WordTuple(index: 4, word: 'word2'), // Misma palabra
          WordTuple(index: 3, word: 'someOtherWord'), // Mismo índice
        ];

        final result = SecretPhraseUtils.areSelectedWordsValid(
            selectedWords, randomIndexes);

        expect(result, isTrue);
      });

      // Caso negativo: una de las listas tiene la longitud incorrecta
      test('should return false when a list has incorrect length', () {
        final selectedWords =
            _generateWordTuples(UiConstants.wordsToVerify - 1);
        final randomIndexes = _generateWordTuples(UiConstants.wordsToVerify);

        final result = SecretPhraseUtils.areSelectedWordsValid(
            selectedWords, randomIndexes);

        expect(result, isFalse);
      });

      // Caso negativo: una palabra no es equivalente
      test('should return false when a single word is not equivalent', () {
        final selectedWords = _generateWordTuples(UiConstants.wordsToVerify);
        final randomIndexes = _generateWordTuples(UiConstants.wordsToVerify);
        // Modificamos un solo elemento para que no sea equivalente
        randomIndexes[1] = WordTuple(index: 99, word: 'totallyDifferent');

        final result = SecretPhraseUtils.areSelectedWordsValid(
            selectedWords, randomIndexes);

        expect(result, isFalse);
      });

      // Caso negativo: el orden de las palabras no coincide
      test('should return false when words are equivalent but in wrong order',
          () {
        final selectedWords = _generateWordTuples(UiConstants.wordsToVerify);
        final randomIndexes = [
          selectedWords[1],
          selectedWords[0],
          selectedWords[2],
        ];

        final result = SecretPhraseUtils.areSelectedWordsValid(
            selectedWords, randomIndexes);

        expect(result, isFalse);
      });

      // Caso positivo: Manejo de palabras repetidas
      test(
          'should return true when lists contain repeated words and are equivalent',
          () {
        final selectedWords = [
          WordTuple(index: 1, word: 'word1'),
          WordTuple(index: 2, word: 'word1'), // Palabra repetida
          WordTuple(index: 3, word: 'word3'),
        ];
        final randomIndexes = [
          WordTuple(
              index: 1, word: 'someOtherWord'), // Equivalente por índice (1)
          WordTuple(index: 2, word: 'word1'), // Equivalente por palabra
          WordTuple(index: 5, word: 'word3'), // Equivalente por palabra
        ];

        final result = SecretPhraseUtils.areSelectedWordsValid(
            selectedWords, randomIndexes);

        expect(result, isTrue);
      });

      // Caso negativo: las listas son equivalentes, pero tienen palabras diferentes y ningún índice que coincida
      test('should return false when equivalence logic fails for all items',
          () {
        final selectedWords = _generateWordTuples(UiConstants.wordsToVerify);
        final randomIndexes = _generateWordTuples(UiConstants.wordsToVerify,
            start: 100); // Índices y palabras diferentes

        final result = SecretPhraseUtils.areSelectedWordsValid(
            selectedWords, randomIndexes);

        expect(result, isFalse);
      });
    });
  });
}
