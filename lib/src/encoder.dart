import 'dart:convert';
import 'dart:typed_data';

import 'package:base32_codec/src/variants.dart';

final class Base32Encoder extends Converter<List<int>, String> {
  final Base32Variant _variant;

  const Base32Encoder() : _variant = Base32Variant.rfc4648;

  const Base32Encoder.hex() : _variant = Base32Variant.rfc4648Hex;

  const Base32Encoder.crockford() : _variant = Base32Variant.crockford;

  @override
  String convert(List<int> input) {
    var numberOfBits = 0;
    var value = 0;
    final encodedBuffer = StringBuffer();
    final data = Uint8List.fromList(input);

    // Iterate over each byte in the data buffer.
    for (var i = 0; i < data.length; i++) {
      // For each byte, we shift the value 8 bits to the left and then bitwise OR
      // it with the next byte. This will append the next byte to the value
      value = (value << 8) | data[i];
      // Increment the number of bits by 8.
      numberOfBits += 8;

      while (numberOfBits >= 5) {
        // We append the character at the index of the value shifted to the right
        // by the number of bits minus 5 and bitwise AND’d with 31. This will
        // get the character at the index of the value shifted to the right
        // by the number of bits minus 5.
        encodedBuffer.writeCharCode(
          _variant.alphabet.codeUnitAt((value >> (numberOfBits - 5)) & 31),
        );
        numberOfBits -= 5;
      }
    }

    // If there are any remaining bits, we shift the value to the left by 5
    if (numberOfBits > 0) {
      encodedBuffer.writeCharCode(
        _variant.alphabet.codeUnitAt((value << (5 - numberOfBits)) & 31),
      );
    }

    // If padding is enabled, we add padding characters until the output length
    if (_variant.padding) {
      while (encodedBuffer.length % 8 != 0) {
        encodedBuffer.writeCharCode('='.codeUnitAt(0));
      }
    }

    return encodedBuffer.toString();
  }
}
