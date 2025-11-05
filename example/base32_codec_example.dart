import 'dart:convert';

import 'package:base32_codec/base32_codec.dart';

void main() {
  final utf8String = utf8.encode('Hello World');
  final base32String = Base32Codec().encode(utf8String);
  final base32HexString = Base32Codec.hex().encode(utf8String);
  final crockfordString = Base32Codec.crockford().encode(utf8String);
  final decodedString = Base32Codec().decode(base32String);

  print('UTF-8 Encoding: $utf8String');
  print('RFC 4648 Base32 Encoding: $base32String');
  print('Base32 Hex Encoding: $base32HexString');
  print("Crockford's Base32 Encoding: $crockfordString");
  print('Decoded string: ${utf8.decode(decodedString)}');
}
