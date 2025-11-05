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

    // The output buffer.
    final output = <int>[];

    for (var i = 0; i < input.length; i++) {
      var char = input[i];
      int? charValue;

      switch (_variant) {
        case Base32Variant.rfc4648:
        case Base32Variant.rfc4648Hex:
          // Skip padding characters.
          if (char == '=') continue;
          charValue = _variant.getCharacterIndex(char);
        case Base32Variant.crockford:
          char = char.toUpperCase();
          if (char == 'O') char = '0';
          if (char == 'I' || char == 'L') char = '1';
          // Crockford alphabet does not have padding.
          charValue = _variant.getCharacterIndex(char);
      }

      // Converts the characters to their 5-bit binary values.
      value = (value << 5) | charValue;
      bits += 5;

      // Converts the 5-bit values to the corresponding 8-bit values.
      // These values are then stored in the output array.
      if (bits >= 8) {
        output.add((value >> (bits - 8)) & 255);
        bits -= 8;
      }
    }
    return Uint8List.fromList(output);
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
