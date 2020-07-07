class Similarity {
  double similar;
  Similarity({
    this.similar,
  });

  static fromMap(Map<String, dynamic> map) {
    return Similarity(
      similar: map["similarity"],
    );
  }

  @override
  String toString() => 'Similarity(similar: $similar)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Similarity && o.similar == similar;
  }

  @override
  int get hashCode => similar.hashCode;
}
