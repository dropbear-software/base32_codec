import 'dart:convert';
import 'dart:typed_data';

import 'package:base32_codec/src/variants.dart';

/// An encoder that converts a list of integers to a Base32-encoded string.
final class Base32Encoder extends Converter<Uint8List, String> {
  final Base32Variant _variant;

  /// Creates a new [Base32Encoder] with the RFC 4648 alphabet.
  const Base32Encoder() : _variant = Base32Variant.rfc4648;

  /// Creates a new [Base32Encoder] with the RFC 4648 hex alphabet.
  const Base32Encoder.hex() : _variant = Base32Variant.rfc4648Hex;

  /// Creates a new [Base32Encoder] with the Crockford alphabet.
  const Base32Encoder.crockford() : _variant = Base32Variant.crockford;

  @override
  String convert(Uint8List input) {
    var numberOfBits = 0;
    var value = 0;
    final encodedBuffer = StringBuffer();

    // Iterate over each byte in the data buffer.
    for (var i = 0; i < input.length; i++) {
      // For each byte, we shift the value 8 bits to the left and then bitwise OR
      // it with the next byte. This will append the next byte to the value
      value = (value << 8) | input[i];
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

  @override
  Sink<Uint8List> startChunkedConversion(Sink<String> sink) {
    return _Base32EncoderSink(sink, _variant);
  }
}

class _Base32EncoderSink implements ChunkedConversionSink<Uint8List> {
  final Sink<String> _outSink;
  final Base32Variant _variant;
  int _numberOfBits = 0;
  int _value = 0;
  int _encodedLength = 0;

  _Base32EncoderSink(this._outSink, this._variant);

  @override
  void add(Uint8List chunk) {
    final buffer = StringBuffer();
    for (var i = 0; i < chunk.length; i++) {
      _value = (_value << 8) | chunk[i];
      _numberOfBits += 8;

      while (_numberOfBits >= 5) {
        buffer.writeCharCode(
          _variant.alphabet.codeUnitAt((_value >> (_numberOfBits - 5)) & 31),
        );
        _numberOfBits -= 5;
      }
    }
    _encodedLength += buffer.length;
    _outSink.add(buffer.toString());
  }

  @override
  void close() {
    final buffer = StringBuffer();
    if (_numberOfBits > 0) {
      buffer.writeCharCode(
        _variant.alphabet.codeUnitAt((_value << (5 - _numberOfBits)) & 31),
      );
    }

    if (_variant.padding) {
      var totalLength = _encodedLength + buffer.length;
      while (totalLength % 8 != 0) {
        buffer.writeCharCode('='.codeUnitAt(0));
        totalLength++;
      }
    }

    _outSink.add(buffer.toString());
    _outSink.close();
  }
}
