# Implementation Plan: Adding Performance Benchmarks to `base32_codec`

This plan outlines the steps to implement performance benchmarks for the `base32_codec` package using `benchmark_harness`. Each phase includes tasks for implementation, testing, code quality, and updating the journal.

## Journal

**Phase 1 - 2025-11-06**

*   Added `benchmark_harness` as a `dev_dependency`.
*   Created the `benchmark/` directory and the initial `benchmark/base32_codec_benchmark.dart` file.
*   Implemented the first two synchronous benchmarks for RFC4648 encoding and decoding.
*   Ran all required code quality and testing tools.
*   No surprises or deviations from the plan.

**Phase 2 - 2025-11-06**

*   Implemented the remaining synchronous benchmarks for RFC4648 Hex and Crockford variants.
*   Updated the `main()` function in `base32_codec_benchmark.dart` to run these new benchmarks.
*   Ran all required code quality and testing tools.
*   No surprises or deviations from the plan.

## Phase 1: Setup `benchmark_harness` and initial synchronous benchmarks

- [x] Run all tests to ensure the project is in a good state before starting modifications.
- [x] Add `benchmark_harness` as a `dev_dependency` in `pubspec.yaml`.
- [x] Create the `benchmark/` directory.
- [x] Create `benchmark/base32_codec_benchmark.dart`.
- [x] Implement `Base32Rfc4648EncodeBenchmark`:
    - Extend `BenchmarkBase`.
    - Override `setup()` to prepare input data (e.g., a repeated string).
    - Override `exercise()` to call `run()` once.
    - Override `run()` to perform `Base32Codec().encode(data)`.
- [x] Implement `Base32Rfc4648DecodeBenchmark`:
    - Extend `BenchmarkBase`.
    - Override `setup()` to prepare encoded input data.
    - Override `exercise()` to call `run()` once.
    - Override `run()` to perform `Base32Codec().decode(encodedData)`.
- [x] Add `main()` function to `base32_codec_benchmark.dart` to run these two benchmarks.
- [x] Create/modify unit tests for testing the code added or modified in this phase, if relevant.
- [x] Run the `dart_fix` tool to clean up the code.
- [x] Run the `analyze_files` tool one more time and fix any issues.
- [x] Run any tests to make sure they all pass.
- [x] Run `dart_format` to make sure that the formatting is correct.
- [x] Re-read the `MODIFICATION_IMPLEMENTATION.md` file to see what, if anything, has changed in the implementation plan, and if it has changed, take care of anything the changes imply.
- [x] Update the `MODIFICATION_IMPLEMENTATION.md` file with the current state, including any learnings, surprises, or deviations in the Journal section. Check off any checkboxes of items that have been completed.
- [ ] Use `git diff` to verify the changes that have been made, and create a suitable commit message for any changes, following any guidelines you have about commit messages. Be sure to properly escape dollar signs and backticks, and present the change message to the user for approval.
- [ ] Wait for approval. Don't commit the changes or move on to the next phase of implementation until the user approves the commit.
- [ ] After committing the change, if an app is running, use the `hot_reload` tool to reload it.

## Phase 2: Implement remaining synchronous benchmarks

- [x] Implement `Base32Rfc4648HexEncodeBenchmark`.
- [x] Implement `Base32Rfc4648HexDecodeBenchmark`.
- [x] Implement `Base32CrockfordEncodeBenchmark`.
- [x] Implement `Base32CrockfordDecodeBenchmark`.
- [x] Update `main()` function in `base32_codec_benchmark.dart` to run these new benchmarks.
- [x] Create/modify unit tests for testing the code added or modified in this phase, if relevant.
- [x] Run the `dart_fix` tool to clean up the code.
- [x] Run the `analyze_files` tool one more time and fix any issues.
- [x] Run any tests to make sure they all pass.
- [x] Run `dart_format` to make sure that the formatting is correct.
- [x] Re-read the `MODIFICATION_IMPLEMENTATION.md` file to see what, if anything, has changed in the implementation plan, and if it has changed, take care of anything the changes imply.
- [x] Update the `MODIFICATION_IMPLEMENTATION.md` file with the current state, including any learnings, surprises, or deviations in the Journal section. Check off any checkboxes of items that have been completed.
- [ ] Use `git diff` to verify the changes that have been made, and create a suitable commit message for any changes, following any guidelines you have about commit messages. Be sure to properly escape dollar signs and backticks, and present the change message to the user for approval.
- [ ] Wait for approval. Don't commit the changes or move on to the next phase of implementation until the user approves the commit.
- [ ] After committing the change, if an app is running, use the `hot_reload` tool to reload it.

## Phase 3: Implement asynchronous (stream) benchmarks

- [ ] Implement `Base32Rfc4648StreamEncodeBenchmark`:
    - Extend `AsyncBenchmarkBase`.
    - Override `setup()` to prepare input data.
    - Override `run()` to perform stream encoding and await its completion.
- [ ] Implement `Base32Rfc4648StreamDecodeBenchmark`:
    - Extend `AsyncBenchmarkBase`.
    - Override `setup()` to prepare encoded input data.
    - Override `run()` to perform stream decoding and await its completion.
- [ ] Implement `Base32Rfc4648HexStreamEncodeBenchmark`.
- [ ] Implement `Base32Rfc4648HexStreamDecodeBenchmark`.
- [ ] Implement `Base32CrockfordStreamEncodeBenchmark`.
- [ ] Implement `Base32CrockfordStreamDecodeBenchmark`.
- [ ] Update `main()` function in `base32_codec_benchmark.dart` to run these new benchmarks.
- [ ] Create/modify unit tests for testing the code added or modified in this phase, if relevant.
- [ ] Run the `dart_fix` tool to clean up the code.
- [ ] Run the `analyze_files` tool one more time and fix any issues.
- [ ] Run any tests to make sure they all pass.
- [ ] Run `dart_format` to make sure that the formatting is correct.
- [ ] Re-read the `MODIFICATION_IMPLEMENTATION.md` file to see what, if anything, has changed in the implementation plan, and if it has changed, take care of anything the changes imply.
- [ ] Update the `MODIFICATION_IMPLEMENTATION.md` file with the current state, including any learnings, surprises, or deviations in the Journal section. Check off any checkboxes of items that have been completed.
- [ ] Use `git diff` to verify the changes that have been made, and create a suitable commit message for any changes, following any guidelines you have about commit messages. Be sure to properly escape dollar signs and backticks, and present the change message to the user for approval.
- [ ] Wait for approval. Don't commit the changes or move on to the next phase of implementation until the user approves the commit.
- [ ] After committing the change, if an app is running, use the `hot_reload` tool to reload it.

## Phase 4: Finalization

- [ ] Update the `README.md` file for the package with relevant information about the new benchmarks (e.g., how to run them).
- [ ] Update the `GEMINI.md` file in the project directory so that it still correctly describes the app, its purpose, and implementation details and the layout of the files.
- [ ] Ask the user to inspect the package and say if they are satisfied with it, or if any modifications are needed.
- [ ] Create/modify unit tests for testing the code added or modified in this phase, if relevant.
- [ ] Run the `dart_fix` tool to clean up the code.
- [ ] Run the `analyze_files` tool one more time and fix any issues.
- [ ] Run any tests to make sure they all pass.
- [ ] Run `dart_format` to make sure that the formatting is correct.
- [ ] Re-read the `MODIFICATION_IMPLEMENTATION.md` file to see what, if anything, has changed in the implementation plan, and if it has changed, take care of anything the changes imply.
- [ ] Update the `MODIFICATION_IMPLEMENTATION.md` file with the current state, including any learnings, surprises, or deviations in the Journal section. Check off any checkboxes of items that have been completed.
- [ ] Use `git diff` to verify the changes that have been made, and create a suitable commit message for any changes, following any guidelines you have about commit messages. Be sure to properly escape dollar signs and backticks, and present the change message to the user for approval.
- [ ] Wait for approval. Don't commit the changes or move on to the next phase of implementation until the user approves the commit.
- [ ] After committing the change, if an app is running, use the `hot_reload` tool to reload it.