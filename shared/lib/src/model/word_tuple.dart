class WordTuple {
  WordTuple({
    required this.index,
    required this.word,
  });

  final int index;
  final String word;

  bool isEquivalent(WordTuple other) {
    return areEquivalent(this, other);
  }

  static bool areEquivalent(WordTuple a, WordTuple b) {
    return a.index == b.index || a.word == b.word;
  }
}
