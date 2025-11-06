[![pub package](https://img.shields.io/pub/v/base32_codec.svg)](https://pub.dev/packages/base32_codec)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Open in Firebase Studio](https://cdn.firebasestudio.dev/btn/open_light_20.svg)](https://studio.firebase.google.com/import?url=https%3A%2F%2Fgithub.com%2Fdropbear-software%2Fbase32_codec)

A flexible and efficient Dart package for encoding and decoding Base32 data.
This package provides a `Codec`-based API that aligns with `dart:convert`
conventions, making it easy to work with synchronous and asynchronous data
streams.

## Features

*   **Multiple Variants:** Supports RFC 4648, RFC 4648 "Hex", and Crockford's
    Base32 alphabets.
*   **Stream-Compatible:** Implements chunked conversion, allowing it to be
    used as a `StreamTransformer` for efficient processing of large data.
*   **Dart Native:** A pure Dart implementation with no platform-specific
    dependencies.
*   **Well-Tested:** Comes with a comprehensive test suite, including RFC 4648
    test vectors.

## Getting started

Add this package to your `pubspec.yaml` file:

```yaml
dependencies:
  base32_codec: ^1.0.0 # Replace with the latest version
```

Then, run `pub get` or `flutter pub get` to install the package.

## Usage

### Synchronous Conversion

For simple, in-memory encoding and decoding, you can use the `encode` and
`decode` methods directly.

**Default (RFC 4648)**

```dart
import 'dart:convert';
import 'package:base32_codec/base32_codec.dart';

void main() {
  final codec = Base32Codec();
  final data = ascii.encode('foobar');

  final encoded = codec.encode(data);
  print(encoded); // MZXW6YTBOI======

  final decoded = codec.decode(encoded);
  print(ascii.decode(decoded)); // foobar
}
```

**Crockford Variant**

To use a different variant, instantiate the corresponding codec.

```dart
import 'dart:convert';
import 'package:base32_codec/base32_codec.dart';

void main() {
  final codec = Base32Codec.crockford();
  final data = ascii.encode('foobar');

  final encoded = codec.encode(data);
  print(encoded); // CSQPYRK1E8

  final decoded = codec.decode(encoded);
  print(ascii.decode(decoded)); // foobar
}
```

### Asynchronous (Stream) Conversion

For handling larger data, like files or network streams, you can use the
codec's encoder and decoder as a `StreamTransformer`.

```dart
import 'dart:convert';
import 'dart:io';
import 'package:base32_codec/base32_codec.dart';

Future<void> main() async {
  // Create a stream from a file or network source
  final inputStream = Stream.value(ascii.encode('foobar'));

  // Transform the stream by encoding it
  final encodedStream = inputStream.transform(Base32Codec().encoder);

  // Print each chunk of the encoded output
  await for (final chunk in encodedStream) {
    print(chunk); // MZXW6YTBOI======
  }

  // You can also pipe the stream to a file
  // await inputStream
  //     .transform(Base32Codec().encoder)
  //     .pipe(File('output.txt').openWrite());
}
```

## Performance Benchmarks

This package includes a suite of performance benchmarks to measure the speed of encoding and decoding operations across different Base32 variants and conversion types (synchronous and asynchronous).

To run the benchmarks, execute the following command from the project root:

```bash
dart run benchmark/base32_codec_benchmark.dart
```

## Contributing

This package is open source and contributions are welcome!

If you find a bug or have a feature request, please file an issue on the
[GitHub issue tracker](https://github.com/dropbear-software/base32_codec/issues). When
filing an issue, please provide a clear description of the problem and include
a minimal, reproducible example if possible.

If you would like to contribute code, please fork the repository and submit a
pull request.
