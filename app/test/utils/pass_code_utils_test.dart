import 'package:app/utils/pass_code_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PassCodeUtils', () {
    group('isValid', () {
      test('should return true for valid pin codes', () {
        expect(PassCodeUtils.isValid('139857'), true);
        expect(PassCodeUtils.isValid('495126'), true);
        expect(PassCodeUtils.isValid('283649'), true);
      });

      test('should return false for repeated digits', () {
        expect(PassCodeUtils.isValid('111111'), false);
        expect(PassCodeUtils.isValid('222222'), false);
        expect(PassCodeUtils.isValid('000000'), false);
        expect(PassCodeUtils.isValid('000001'), true);
      });

      test('should return false for ascending sequences', () {
        expect(PassCodeUtils.isValid('123456'), false);
        expect(PassCodeUtils.isValid('234567'), false);
        expect(PassCodeUtils.isValid('678901'), false);
      });

      test('should return false for descending sequences', () {
        expect(PassCodeUtils.isValid('654321'), false);
        expect(PassCodeUtils.isValid('987654'), false);
        expect(PassCodeUtils.isValid('109876'), false);
      });

      test('should return false for weak patterns', () {
        expect(PassCodeUtils.isValid('123456'), false);
        expect(PassCodeUtils.isValid('654321'), false);
        expect(PassCodeUtils.isValid('333333'), false);
        expect(PassCodeUtils.isValid('777777'), false);
      });

      test('should return false for invalid length', () {
        expect(PassCodeUtils.isValid('12345'), false);
        expect(PassCodeUtils.isValid('1234567'), false);
        expect(PassCodeUtils.isValid(''), false);
      });

      test('should handle edge case patterns correctly', () {
        expect(PassCodeUtils.isValid('901234'),
            false); // Ascending with wraparound
        expect(PassCodeUtils.isValid('098765'),
            false); // Descending with wraparound
      });

      test('deberia devolver false si mando letras', () {
        expect(PassCodeUtils.isValid('abcdef'), false);
        expect(PassCodeUtils.isValid('a23456'), false);
      });
    });

    group('arePinsMatching', () {
      test('should return true when pins match exactly', () {
        expect(PassCodeUtils.arePinsMatching('123456', '123456'), true);
        expect(PassCodeUtils.arePinsMatching('000000', '000000'), true);
        expect(PassCodeUtils.arePinsMatching('', ''), true);
      });

      test('should return false when pins do not match', () {
        expect(PassCodeUtils.arePinsMatching('123456', '123457'), false);
        expect(PassCodeUtils.arePinsMatching('111111', '222222'), false);
        expect(PassCodeUtils.arePinsMatching('123456', ''), false);
        expect(PassCodeUtils.arePinsMatching('', '123456'), false);
      });

      test('should be case sensitive for non-numeric strings', () {
        expect(PassCodeUtils.arePinsMatching('AbC123', 'abc123'), false);
        expect(PassCodeUtils.arePinsMatching('ABC123', 'ABC123'), true);
      });
    });
  });
}
