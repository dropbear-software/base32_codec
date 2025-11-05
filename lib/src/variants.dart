enum Base32Variant {
  rfc4648(alphabet: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567', padding: true),
  rfc4648Hex(alphabet: '0123456789ABCDEFGHIJKLMNOPQRSTUV', padding: true),
  crockford(alphabet: '0123456789ABCDEFGHJKMNPQRSTVWXYZ', padding: false);

  const Base32Variant({required this.alphabet, required this.padding});

  final String alphabet;
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
