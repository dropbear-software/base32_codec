import 'dart:convert';

import 'package:base32_codec/base32_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Base32Codec RFC 4648', () {
    final codec = Base32Codec();
    // Test vectors from RFC 4648
    test('""', () {
      expect(codec.encode(ascii.encode('')), equals(''));
      expect(codec.decode(''), equals(ascii.encode('')));
    });
    test('"f"', () {
      expect(codec.encode(ascii.encode('f')), equals('MY======'));
      expect(codec.decode('MY======'), equals(ascii.encode('f')));
    });
    test('"fo"', () {
      expect(codec.encode(ascii.encode('fo')), equals('MZXQ===='));
      expect(codec.decode('MZXQ===='), equals(ascii.encode('fo')));
    });
    test('"foo"', () {
      expect(codec.encode(ascii.encode('foo')), equals('MZXW6==='));
      expect(codec.decode('MZXW6==='), equals(ascii.encode('foo')));
    });
    test('"foob"', () {
      expect(codec.encode(ascii.encode('foob')), equals('MZXW6YQ='));
      expect(codec.decode('MZXW6YQ='), equals(ascii.encode('foob')));
    });
    test('"fooba"', () {
      expect(codec.encode(ascii.encode('fooba')), equals('MZXW6YTB'));
      expect(codec.decode('MZXW6YTB'), equals(ascii.encode('fooba')));
    });
    test('"foobar"', () {
      expect(codec.encode(ascii.encode('foobar')), equals('MZXW6YTBOI======'));
      expect(codec.decode('MZXW6YTBOI======'), equals(ascii.encode('foobar')));
    });
  });

  group('Base32Codec RFC 4648 Hex', () {
    final codec = Base32Codec.hex();
    // Test vectors from RFC 4648
    test('""', () {
      expect(codec.encode(ascii.encode('')), equals(''));
      expect(codec.decode(''), equals(ascii.encode('')));
    });
    test('"f"', () {
      expect(codec.encode(ascii.encode('f')), equals('CO======'));
      expect(codec.decode('CO======'), equals(ascii.encode('f')));
    });
    test('"fo"', () {
      expect(codec.encode(ascii.encode('fo')), equals('CPNG===='));
      expect(codec.decode('CPNG===='), equals(ascii.encode('fo')));
    });
    test('"foo"', () {
      expect(codec.encode(ascii.encode('foo')), equals('CPNMU==='));
      expect(codec.decode('CPNMU==='), equals(ascii.encode('foo')));
    });
    test('"foob"', () {
      expect(codec.encode(ascii.encode('foob')), equals('CPNMUOG='));
      expect(codec.decode('CPNMUOG='), equals(ascii.encode('foob')));
    });
    test('"fooba"', () {
      expect(codec.encode(ascii.encode('fooba')), equals('CPNMUOJ1'));
      expect(codec.decode('CPNMUOJ1'), equals(ascii.encode('fooba')));
    });
    test('"foobar"', () {
      expect(codec.encode(ascii.encode('foobar')), equals('CPNMUOJ1E8======'));
      expect(codec.decode('CPNMUOJ1E8======'), equals(ascii.encode('foobar')));
    });
  });

  group('Base32Codec Crockford', () {
    final codec = Base32Codec.crockford();
    test('"f"', () {
      expect(codec.encode(ascii.encode('f')), equals('CR'));
      expect(codec.decode('CR'), equals(ascii.encode('f')));
    });
    test('"fo"', () {
      expect(codec.encode(ascii.encode('fo')), equals('CSQG'));
      expect(codec.decode('CSQG'), equals(ascii.encode('fo')));
    });
    test('"foo"', () {
      expect(codec.encode(ascii.encode('foo')), equals('CSQPY'));
      expect(codec.decode('CSQPY'), equals(ascii.encode('foo')));
    });
    test('"foob"', () {
      expect(codec.encode(ascii.encode('foob')), equals('CSQPYRG'));
      expect(codec.decode('CSQPYRG'), equals(ascii.encode('foob')));
    });
    test('"fooba"', () {
      expect(codec.encode(ascii.encode('fooba')), equals('CSQPYRK1'));
      expect(codec.decode('CSQPYRK1'), equals(ascii.encode('fooba')));
    });
    test('"foobar"', () {
      expect(codec.encode(ascii.encode('foobar')), equals('CSQPYRK1E8'));
      expect(codec.decode('CSQPYRK1E8'), equals(ascii.encode('foobar')));
    });
  });
}
