part of 'similarity_bloc.dart';

abstract class SimilarityEvent extends Equatable {
  const SimilarityEvent();
  @override
  List<Object> get props => [];
}

class FetchSimilarityDataEvent extends SimilarityEvent {

  final String myDefinition;
  final String original;

  FetchSimilarityDataEvent({@required this.myDefinition, this.original})
      : assert(myDefinition != null && original != null);

  @override
  String toString() =>
      "FetchSimilarityDataEvent {original: $original, myDefinition: $myDefinition}";
}
