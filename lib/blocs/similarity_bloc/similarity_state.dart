part of 'similarity_bloc.dart';

abstract class SimilarityState extends Equatable {
  const SimilarityState();
  @override
  List<Object> get props => [];
}

class SimilarityInitial extends SimilarityState {}

class LoadingSemanticState extends SimilarityState {}

class LoadedSimilarityState extends SimilarityState {
  final Similarity similarity;

  LoadedSimilarityState({@required this.similarity})
      : assert(similarity != null);
}

class ErrorSimilarityState extends SimilarityState {
  final String message;

  ErrorSimilarityState({@required this.message});
}
