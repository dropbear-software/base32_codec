import 'dart:convert';

import 'package:base32_codec/src/decoder.dart';
import 'package:base32_codec/src/encoder.dart';

final class Base32Codec extends Codec<List<int>, String> {
  final Base32Encoder _encoder;
  final Base32Decoder _decoder;

  const Base32Codec()
    : _encoder = const Base32Encoder(),
      _decoder = const Base32Decoder();
  const Base32Codec.hex()
    : _encoder = const Base32Encoder.hex(),
      _decoder = const Base32Decoder.hex();
  const Base32Codec.crockford()
    : _encoder = const Base32Encoder.crockford(),
      _decoder = const Base32Decoder.crockford();

  @override
  Converter<String, List<int>> get decoder => _decoder;

  @override
  Converter<List<int>, String> get encoder => _encoder;
}
