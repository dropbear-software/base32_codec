import 'dart:convert';
import 'dart:typed_data';

import 'package:base32_codec/src/variants.dart';

/// A decoder that converts a Base32-encoded string to a list of integers.
final class Base32Decoder extends Converter<String, Uint8List> {
  final Base32Variant _variant;

  /// Creates a new [Base32Decoder] with the RFC 4648 alphabet.
  const Base32Decoder() : _variant = Base32Variant.rfc4648;

  /// Creates a new [Base32Decoder] with the RFC 4648 hex alphabet.
  const Base32Decoder.hex() : _variant = Base32Variant.rfc4648Hex;

  /// Creates a new [Base32Decoder] with the Crockford alphabet.
  const Base32Decoder.crockford() : _variant = Base32Variant.crockford;

  @override
  Uint8List convert(String input) {
    var bits = 0;
    var value = 0;

    // Find the length of the string without padding.
    // We iterate backwards from the end to find the first non-'=' char.
    // This is O(padding_length), which is extremely fast and constant-time (max 6).
    var relevantLength = input.length;
    if (_variant.padding) {
      while (relevantLength > 0 && input[relevantLength - 1] == '=') {
        relevantLength--;
      }
    }

    // Loop *only* over the relevant (non-padding) part of the string.
    var effectiveLength = 0;
    for (var i = 0; i < relevantLength; i++) {
      final char = input[i];
      if (_variant == Base32Variant.crockford && char == '-') {
        continue;
      }
      effectiveLength++;
    }

    final decodedLength = (effectiveLength * 5) ~/ 8;
    final output = Uint8List(decodedLength);
    var outputIndex = 0;

    for (var i = 0; i < relevantLength; i++) {
      var char = input[i];
      int? charValue;

      switch (_variant) {
        case Base32Variant.rfc4648:
        case Base32Variant.rfc4648Hex:
          // No need to check for '=' anymore, as we stop before padding.
          charValue = _variant.getCharacterIndex(char);
        case Base32Variant.crockford:
          if (char == '-') continue;
          char = char.toUpperCase();
          if (char == 'O') char = '0';
          if (char == 'I' || char == 'L') char = '1';
          charValue = _variant.getCharacterIndex(char);
      }

      value = (value << 5) | charValue;
      bits += 5;

      if (bits >= 8) {
        // Write directly to the pre-allocated list
        output[outputIndex++] = (value >> (bits - 8)) & 255;
        bits -= 8;
      }
    }
    return output;
  }

  @override
  Sink<String> startChunkedConversion(Sink<Uint8List> sink) {
    return _Base32DecoderSink(sink, _variant);
  }
}

class _Base32DecoderSink implements ChunkedConversionSink<String> {
  final Sink<Uint8List> _outSink;
  final Base32Variant _variant;
  int _value = 0;
  int _bits = 0;

  _Base32DecoderSink(this._outSink, this._variant);

  @override
  void add(String chunk) {
    final output = <int>[];
    for (var i = 0; i < chunk.length; i++) {
      var char = chunk[i];
      int? charValue;

      switch (_variant) {
        case Base32Variant.rfc4648:
        case Base32Variant.rfc4648Hex:
          if (char == '=') continue; // Skip padding
          charValue = _variant.getCharacterIndex(char);
        case Base32Variant.crockford:
          char = char.toUpperCase();
          if (char == 'O') char = '0';
          if (char == 'I' || char == 'L') char = '1';
          // Crockford alphabet does not have padding.
          charValue = _variant.getCharacterIndex(char);
      }

      _value = (_value << 5) | charValue;
      _bits += 5;

      if (_bits >= 8) {
        output.add((_value >> (_bits - 8)) & 255);
        _bits -= 8;
      }
    }
    if (output.isNotEmpty) {
      _outSink.add(Uint8List.fromList(output));
    }
  }

  @override
  void close() {
    _outSink.close();
  }
}
