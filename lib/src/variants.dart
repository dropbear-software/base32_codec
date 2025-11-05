/// The variant of the Base32 encoding.
enum Base32Variant {
  /// The RFC 4648 variant.
  rfc4648(alphabet: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567', padding: true),

  /// The RFC 4648 hex variant.
  rfc4648Hex(alphabet: '0123456789ABCDEFGHIJKLMNOPQRSTUV', padding: true),

  /// The Crockford variant.
  crockford(alphabet: '0123456789ABCDEFGHJKMNPQRSTVWXYZ', padding: false);

  /// Creates a new [Base32Variant].
  const Base32Variant({required this.alphabet, required this.padding});

  /// The alphabet of the variant.
  final String alphabet;

  /// Whether the variant uses padding.
  final bool padding;

  /// Returns the index of the character in the alphabet for a given encoding.
  int getCharacterIndex(String char) {
    final index = alphabet.indexOf(char[0]);
    if (index == -1) {
      throw ArgumentError.value(char, 'char', 'Invalid character found');
    }

    return index;
  }
}
