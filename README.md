<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

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

## Contributing

This package is open source and contributions are welcome!

If you find a bug or have a feature request, please file an issue on the
[GitHub issue tracker](https://github.com/dropbear-software/base32_codec/issues). When
filing an issue, please provide a clear description of the problem and include
a minimal, reproducible example if possible.

If you would like to contribute code, please fork the repository and submit a
pull request.
