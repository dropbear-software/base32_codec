// Import BenchmarkBase class.
import 'dart:async';
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

class Base32Rfc4648HexEncodeBenchmark extends BenchmarkBase {
  final Base32Codec _codec = const Base32Codec.hex();
  late Uint8List _data;

  Base32Rfc4648HexEncodeBenchmark() : super('Base32.RFC4648Hex.Encode');

  @override
  void setup() {
    _data = ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100);
  }

  @override
  void run() {
    _codec.encode(_data);
  }

  @override
  void exercise() => run();
}

class Base32Rfc4648HexDecodeBenchmark extends BenchmarkBase {
  final Base32Codec _codec = const Base32Codec.hex();
  late String _encodedData;

  Base32Rfc4648HexDecodeBenchmark() : super('Base32.RFC4648Hex.Decode');

  @override
  void setup() {
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

class Base32CrockfordEncodeBenchmark extends BenchmarkBase {
  final Base32Codec _codec = const Base32Codec.crockford();
  late Uint8List _data;

  Base32CrockfordEncodeBenchmark() : super('Base32.Crockford.Encode');

  @override
  void setup() {
    _data = ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100);
  }

  @override
  void run() {
    _codec.encode(_data);
  }

  @override
  void exercise() => run();
}

class Base32CrockfordDecodeBenchmark extends BenchmarkBase {
  final Base32Codec _codec = const Base32Codec.crockford();
  late String _encodedData;

  Base32CrockfordDecodeBenchmark() : super('Base32.Crockford.Decode');

  @override
  void setup() {
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

// Asynchronous (Stream) Benchmarks

class Base32Rfc4648StreamEncodeBenchmark extends AsyncBenchmarkBase {
  final Base32Codec _codec = const Base32Codec();
  late Stream<Uint8List> _inputStream;
  late Uint8List _data;

  Base32Rfc4648StreamEncodeBenchmark() : super('Base32.RFC4648.StreamEncode');

  @override
  Future<void> setup() async {
    _data = ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100);
  }

  @override
  Future<void> run() async {
    _inputStream = Stream.value(_data);
    await _inputStream.transform(_codec.encoder).last;
  }
}

class Base32Rfc4648StreamDecodeBenchmark extends AsyncBenchmarkBase {
  final Base32Codec _codec = const Base32Codec();
  late Stream<String> _inputStream;
  late String _encodedData;

  Base32Rfc4648StreamDecodeBenchmark() : super('Base32.RFC4648.StreamDecode');

  @override
  Future<void> setup() async {
    _encodedData = _codec.encode(
      ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100),
    );
  }

  @override
  Future<void> run() async {
    _inputStream = Stream.value(_encodedData);
    await _inputStream.transform(_codec.decoder).last;
  }
}

class Base32Rfc4648HexStreamEncodeBenchmark extends AsyncBenchmarkBase {
  final Base32Codec _codec = const Base32Codec.hex();
  late Stream<Uint8List> _inputStream;
  late Uint8List _data;

  Base32Rfc4648HexStreamEncodeBenchmark()
    : super('Base32.RFC4648Hex.StreamEncode');

  @override
  Future<void> setup() async {
    _data = ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100);
  }

  @override
  Future<void> run() async {
    _inputStream = Stream.value(_data);
    await _inputStream.transform(_codec.encoder).last;
  }
}

class Base32Rfc4648HexStreamDecodeBenchmark extends AsyncBenchmarkBase {
  final Base32Codec _codec = const Base32Codec.hex();
  late Stream<String> _inputStream;
  late String _encodedData;

  Base32Rfc4648HexStreamDecodeBenchmark()
    : super('Base32.RFC4648Hex.StreamDecode');

  @override
  Future<void> setup() async {
    _encodedData = _codec.encode(
      ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100),
    );
  }

  @override
  Future<void> run() async {
    _inputStream = Stream.value(_encodedData);
    await _inputStream.transform(_codec.decoder).last;
  }
}

class Base32CrockfordStreamEncodeBenchmark extends AsyncBenchmarkBase {
  final Base32Codec _codec = const Base32Codec.crockford();
  late Stream<Uint8List> _inputStream;
  late Uint8List _data;

  Base32CrockfordStreamEncodeBenchmark()
    : super('Base32.Crockford.StreamEncode');

  @override
  Future<void> setup() async {
    _data = ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100);
  }

  @override
  Future<void> run() async {
    _inputStream = Stream.value(_data);
    await _inputStream.transform(_codec.encoder).last;
  }
}

class Base32CrockfordStreamDecodeBenchmark extends AsyncBenchmarkBase {
  final Base32Codec _codec = const Base32Codec.crockford();
  late Stream<String> _inputStream;
  late String _encodedData;

  Base32CrockfordStreamDecodeBenchmark()
    : super('Base32.Crockford.StreamDecode');

  @override
  Future<void> setup() async {
    _encodedData = _codec.encode(
      ascii.encode('The quick brown fox jumps over the lazy dog. ' * 100),
    );
  }

  @override
  Future<void> run() async {
    _inputStream = Stream.value(_encodedData);
    await _inputStream.transform(_codec.decoder).last;
  }
}

Future<void> main() async {
  Base32Rfc4648EncodeBenchmark().report();
  Base32Rfc4648DecodeBenchmark().report();
  Base32Rfc4648HexEncodeBenchmark().report();
  Base32Rfc4648HexDecodeBenchmark().report();
  Base32CrockfordEncodeBenchmark().report();
  Base32CrockfordDecodeBenchmark().report();

  // Asynchronous benchmarks
  await Base32Rfc4648StreamEncodeBenchmark().report();
  await Base32Rfc4648StreamDecodeBenchmark().report();
  await Base32Rfc4648HexStreamEncodeBenchmark().report();
  await Base32Rfc4648HexStreamDecodeBenchmark().report();
  await Base32CrockfordStreamEncodeBenchmark().report();
  await Base32CrockfordStreamDecodeBenchmark().report();
}
