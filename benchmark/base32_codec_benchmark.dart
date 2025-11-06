// Import BenchmarkBase class.
import 'dart:convert';
import 'dart:typed_data';

import 'package:base32_codec/base32_codec.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

// Create a new benchmark by extending BenchmarkBase
class Base32Rfc4648EncodeBenchmark extends BenchmarkBase {
  final Base32Codec _codec = const Base32Codec();
  late Uint8List _data;

  Base32Rfc4648EncodeBenchmark() : super('Base32.RFC4648.Encode');

  @override
  void setup() {
    // Prepare data for encoding. Using a reasonably sized string.
    _data = ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100);
  }

  @override
  void run() {
    _codec.encode(_data);
  }

  @override
  void exercise() => run();
}

class Base32Rfc4648DecodeBenchmark extends BenchmarkBase {
  final Base32Codec _codec = const Base32Codec();
  late String _encodedData;

  Base32Rfc4648DecodeBenchmark() : super('Base32.RFC4648.Decode');

  @override
  void setup() {
    // Prepare data for encoding. Using a reasonably sized string.
    _encodedData = _codec.encode(
      ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100),
    );
  }

  @override
  void run() {
    _codec.decode(_encodedData);
  }

  @override
  void exercise() => run();
}

void main() {
  Base32Rfc4648EncodeBenchmark().report();
  Base32Rfc4648DecodeBenchmark().report();
}
