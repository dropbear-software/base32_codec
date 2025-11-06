// Import BenchmarkBase class.
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:base32_codec/base32_codec.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

// Test data
final _testData = ascii.encode(
  'The quick brown fox jumps over the lazy dog. ' * 100,
);

// Abstract base class for sync encoding
abstract class _SyncEncodeBenchmark extends BenchmarkBase {
  final Base32Codec _codec;
  late final Uint8List _data;

  _SyncEncodeBenchmark(super.name, this._codec);

  @override
  void setup() {
    _data = _testData;
  }

  @override
  void run() {
    _codec.encode(_data);
  }

  @override
  void exercise() => run();
}

// Abstract base class for sync decoding
abstract class _SyncDecodeBenchmark extends BenchmarkBase {
  final Base32Codec _codec;
  late final String _encodedData;

  _SyncDecodeBenchmark(super.name, this._codec);

  @override
  void setup() {
    _encodedData = _codec.encode(_testData);
  }

  @override
  void run() {
    _codec.decode(_encodedData);
  }

  @override
  void exercise() => run();
}

// Abstract base class for async encoding
abstract class _AsyncEncodeBenchmark extends AsyncBenchmarkBase {
  final Base32Codec _codec;

  _AsyncEncodeBenchmark(super.name, this._codec);

  @override
  Future<void> run() async {
    final inputStream = Stream.value(_testData);
    await inputStream.transform(_codec.encoder).last;
  }
}

// Abstract base class for async decoding
abstract class _AsyncDecodeBenchmark extends AsyncBenchmarkBase {
  final Base32Codec _codec;
  late final String _encodedData;

  _AsyncDecodeBenchmark(super.name, this._codec);

  @override
  Future<void> setup() async {
    _encodedData = _codec.encode(_testData);
  }

  @override
  Future<void> run() async {
    final inputStream = Stream.value(_encodedData);
    await inputStream.transform(_codec.decoder).last;
  }
}

// Concrete benchmark implementations

class Base32Rfc4648EncodeBenchmark extends _SyncEncodeBenchmark {
  Base32Rfc4648EncodeBenchmark()
    : super('Base32.RFC4648.Encode', const Base32Codec());
}

class Base32Rfc4648DecodeBenchmark extends _SyncDecodeBenchmark {
  Base32Rfc4648DecodeBenchmark()
    : super('Base32.RFC4648.Decode', const Base32Codec());
}

class Base32Rfc4648HexEncodeBenchmark extends _SyncEncodeBenchmark {
  Base32Rfc4648HexEncodeBenchmark()
    : super('Base32.RFC4648Hex.Encode', const Base32Codec.hex());
}

class Base32Rfc4648HexDecodeBenchmark extends _SyncDecodeBenchmark {
  Base32Rfc4648HexDecodeBenchmark()
    : super('Base32.RFC4648Hex.Decode', const Base32Codec.hex());
}

class Base32CrockfordEncodeBenchmark extends _SyncEncodeBenchmark {
  Base32CrockfordEncodeBenchmark()
    : super('Base32.Crockford.Encode', const Base32Codec.crockford());
}

class Base32CrockfordDecodeBenchmark extends _SyncDecodeBenchmark {
  Base32CrockfordDecodeBenchmark()
    : super('Base32.Crockford.Decode', const Base32Codec.crockford());
}

class Base32Rfc4648StreamEncodeBenchmark extends _AsyncEncodeBenchmark {
  Base32Rfc4648StreamEncodeBenchmark()
    : super('Base32.RFC4648.StreamEncode', const Base32Codec());
}

class Base32Rfc4648StreamDecodeBenchmark extends _AsyncDecodeBenchmark {
  Base32Rfc4648StreamDecodeBenchmark()
    : super('Base32.RFC4648.StreamDecode', const Base32Codec());
}

class Base32Rfc4648HexStreamEncodeBenchmark extends _AsyncEncodeBenchmark {
  Base32Rfc4648HexStreamEncodeBenchmark()
    : super('Base32.RFC4648Hex.StreamEncode', const Base32Codec.hex());
}

class Base32Rfc4648HexStreamDecodeBenchmark extends _AsyncDecodeBenchmark {
  Base32Rfc4648HexStreamDecodeBenchmark()
    : super('Base32.RFC4648Hex.StreamDecode', const Base32Codec.hex());
}

class Base32CrockfordStreamEncodeBenchmark extends _AsyncEncodeBenchmark {
  Base32CrockfordStreamEncodeBenchmark()
    : super('Base32.Crockford.StreamEncode', const Base32Codec.crockford());
}

class Base32CrockfordStreamDecodeBenchmark extends _AsyncDecodeBenchmark {
  Base32CrockfordStreamDecodeBenchmark()
    : super('Base32.Crockford.StreamDecode', const Base32Codec.crockford());
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
