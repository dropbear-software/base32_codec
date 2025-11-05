import 'dart:convert';
import 'dart:typed_data';

import 'package:base32_codec/src/decoder.dart';
import 'package:base32_codec/src/encoder.dart';

/// A codec for Base32 encoding and decoding.
///
/// A [Base32Codec] allows you to encode and decode data using the Base32
/// format. It supports multiple variants of the Base32 alphabet.
///
/// ```dart
/// import 'dart:convert';
/// import 'package:base32_codec/base32_codec.dart';
///
/// void main() {
///   final codec = Base32Codec();
///   final data = ascii.encode('foobar');
///
///   final encoded = codec.encode(data);
///   print(encoded); // MZXW6YTBOI======
///
///   final decoded = codec.decode(encoded);
///   print(ascii.decode(decoded)); // foobar
/// }
/// ```
final class Base32Codec extends Codec<Uint8List, String> {
  final Base32Encoder _encoder;
  final Base32Decoder _decoder;

  /// Creates a new [Base32Codec] with the RFC 4648 alphabet.
  const Base32Codec()
      : _encoder = const Base32Encoder(),
        _decoder = const Base32Decoder();

  /// Creates a new [Base32Codec] with the RFC 4648 hex alphabet.
  const Base32Codec.hex()
      : _encoder = const Base32Encoder.hex(),
        _decoder = const Base32Decoder.hex();

  /// Creates a new [Base32Codec] with the Crockford alphabet.
  const Base32Codec.crockford()
      : _encoder = const Base32Encoder.crockford(),
        _decoder = const Base32Decoder.crockford();

  @override
  Converter<String, Uint8List> get decoder => _decoder;

  @override
  Converter<Uint8List, String> get encoder => _encoder;
}
