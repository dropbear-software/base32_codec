# Project Overview

This project is a Dart package named `base32_codec`. It provides a flexible and efficient way to encode and decode Base32 data, following the conventions of `dart:convert`. The package is written in pure Dart and has no platform-specific dependencies.

## Key Features

*   **Multiple Base32 Variants:** Supports three popular Base32 alphabets:
    *   RFC 4648 (the standard)
    *   RFC 4648 "Hex"
    *   Crockford's Base32
*   **Stream-Based Conversion:** The API is compatible with Dart's `Stream` and `Codec` interfaces, making it suitable for processing large data sets without loading everything into memory.
*   **Synchronous Conversion:** For smaller data, the library provides simple `encode` and `decode` methods.

# Building and Running

This is a Dart library, so there is no main executable to run. However, you can run the tests to verify its functionality.

## Running Tests

The project uses the `test` package for testing. To run the tests, use the following command:

```bash
dart test
```

# Development Conventions

## Code Style

The project follows the standard Dart and Flutter linting rules, as defined in the `analysis_options.yaml` file. The `lints` package is used to enforce these rules.

## Testing

The project has a comprehensive test suite in the `test` directory. The tests cover all three Base32 variants and include test vectors from RFC 4648 to ensure correctness. The tests also cover the stream-based (chunked) conversion logic.
