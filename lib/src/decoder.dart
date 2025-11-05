import 'dart:convert';
import 'dart:typed_data';

import 'package:base32_codec/src/variants.dart';

final class Base32Decoder extends Converter<String, List<int>> {
  final Base32Variant _variant;

  const Base32Decoder() : _variant = Base32Variant.rfc4648;
  const Base32Decoder.hex() : _variant = Base32Variant.rfc4648Hex;
  const Base32Decoder.crockford() : _variant = Base32Variant.crockford;

  @override
  List<int> convert(String input) {
    // Remove padding characters from the input data.
    // Note: RFC 4648 requires the padding characters to be at the end of the
    // string, but Crockford allows them anywhere in the string and the padding
    // characters are simply ignored.
    switch (_variant) {
      case Base32Variant.rfc4648:
      case Base32Variant.rfc4648Hex:
        input = input.replaceAll(RegExp(r'=+$'), '');
      case Base32Variant.crockford:
        input = input
            .toUpperCase()
            .replaceAll('O', '0')
            .replaceAll(RegExp('[IL]'), '1');
    }

    // Calculate the output length and initialize an appropriately sized
    // [Uint8List] object to hold the decoded data.
    final length = input.length;
    final outputLength = (length * 5 / 8).floor();
    final output = Uint8List(outputLength);

    // Decode the data.
    var bits = 0;
    var value = 0;
    var index = 0;

    for (var i = 0; i < length; i++) {
      // Converts the characters to their 5-bit binary values.
      value = (value << 5) | _variant.getCharacterIndex(input[i]);
      bits += 5;

      // Converts the 5-bit values to the corresponding 8-bit values.
      // These values are then stored in the output array.
      if (bits >= 8) {
        output[index++] = (value >> (bits - 8)) & 255;
        bits -= 8;
      }
    }

    return output;
  }
}
