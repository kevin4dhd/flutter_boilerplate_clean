import 'package:app/utils/text_parser_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextParserUtils', () {
    group('parseClickableText', () {
      test('should parse simple clickable text with id first format', () {
        const text = 'Accept {1,Terms} and {2,Privacy}';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 4);
        expect(segments[0].text, 'Accept ');
        expect(segments[0].index, 0);
        expect(segments[1].text, 'Terms');
        expect(segments[1].index, 1);
        expect(segments[2].text, ' and ');
        expect(segments[2].index, 0);
        expect(segments[3].text, 'Privacy');
        expect(segments[3].index, 2);
      });

      test('should parse clickable text with text first format', () {
        const text = 'Click {Help,1} for assistance';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 3);
        expect(segments[0].text, 'Click ');
        expect(segments[0].index, 0);
        expect(segments[1].text, 'Help');
        expect(segments[1].index, 1);
        expect(segments[2].text, ' for assistance');
        expect(segments[2].index, 0);
      });

      test('should handle text without clickable links', () {
        const text = 'This is plain text without any links';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 1);
        expect(segments[0].text, text);
        expect(segments[0].index, 0);
      });

      test('should handle empty text', () {
        const text = '';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 0);
      });

      test('should handle malformed links gracefully', () {
        const text = 'Text with {malformed link} and {1,valid}';
        final segments = TextParserUtils.parseClickableText(text);
        expect(segments.length, 4);
        expect(segments[0].text, 'Text with ');
        expect(segments[0].index, 0);
        expect(segments[1].text, '{malformed link}');
        expect(segments[1].index, 0);
        expect(segments[2].text, ' and ');
        expect(segments[2].index, 0);
        expect(segments[3].text, 'valid');
        expect(segments[3].index, 1);
      });

      test('should handle unclosed brackets gracefully', () {
        const text = 'Text with {unclosed bracket';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 1);
        expect(segments[0].text, 'Text with ');
        expect(segments[0].index, 0);
      });

      test('should handle multiple consecutive links', () {
        const text = '{1,First}{2,Second}{3,Third}';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 3);
        expect(segments[0].text, 'First');
        expect(segments[0].index, 1);
        expect(segments[1].text, 'Second');
        expect(segments[1].index, 2);
        expect(segments[2].text, 'Third');
        expect(segments[2].index, 3);
      });

      test('should handle non-numeric ids gracefully', () {
        const text = 'Click {abc,link}';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 2);
        expect(segments[0].text, 'Click ');
        expect(segments[0].index, 0);
        expect(segments[1].text, '{abc,link}');
        expect(segments[1].index, 0);
      });

      test('should handle whitespace in link definitions', () {
        const text = 'Click { 1 , Terms }';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 2);
        expect(segments[0].text, 'Click ');
        expect(segments[0].index, 0);
        expect(segments[1].text, 'Terms');
        expect(segments[1].index, 1);
      });

      test('should handle mixed valid and invalid links', () {
        const text = 'Start {1,Valid} middle {invalid} end {2,Another}';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 6);
        expect(segments[0].text, 'Start ');
        expect(segments[0].index, 0);
        expect(segments[1].text, 'Valid');
        expect(segments[1].index, 1);
        expect(segments[2].text, ' middle ');
        expect(segments[2].index, 0);
        expect(segments[3].text, '{invalid}');
        expect(segments[3].index, 0);
        expect(segments[4].text, ' end ');
        expect(segments[4].index, 0);
        expect(segments[5].text, 'Another');
        expect(segments[5].index, 2);
      });

      test('should handle empty link content', () {
        const text = 'Text {1,} and {,2}';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 4);
        expect(segments[0].text, 'Text ');
        expect(segments[0].index, 0);
        expect(segments[1].text, '{1,}');
        expect(segments[1].index, 0);
        expect(segments[2].text, ' and ');
        expect(segments[2].index, 0);
        expect(segments[3].text, '{,2}');
        expect(segments[3].index, 0);
      });

      test('should handle negative numbers as ids', () {
        const text = 'Click {-1,Negative}';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 2);
        expect(segments[0].text, 'Click ');
        expect(segments[0].index, 0);
        expect(segments[1].text, 'Negative');
        expect(segments[1].index, -1);
      });

      test('should handle zero as id', () {
        const text = 'Click {0,Zero}';
        final segments = TextParserUtils.parseClickableText(text);

        expect(segments.length, 2);
        expect(segments[0].text, 'Click ');
        expect(segments[0].index, 0);
        expect(segments[1].text, 'Zero');
        expect(segments[1].index, 0);
      });
    });
  });
}
