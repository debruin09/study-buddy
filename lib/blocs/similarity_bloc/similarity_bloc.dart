import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/models/similarity.dart';
import 'package:study_buddy/repositories/similarity_repository.dart';

part 'similarity_event.dart';
part 'similarity_state.dart';

class SimilarityBloc extends Bloc<SimilarityEvent, SimilarityState> {
  @override
  SimilarityState get initialState => SimilarityInitial();

  final SimilarityRepository repository;
  SimilarityBloc({@required this.repository}) : assert(repository != null);

  @override
  Stream<SimilarityState> mapEventToState(
    SimilarityEvent event,
  ) async* {
    if (event is FetchSimilarityDataEvent) {
      yield LoadingSemanticState();
      try {
        final Similarity similarity = await repository.fetchSimilarityData(
            original: event.original ?? "",
            myDefenition: event.myDefinition ?? "");
        yield LoadedSimilarityState(similarity: similarity);
      } catch (e) {
        yield ErrorSimilarityState(message: e.toString());
      }
    }
  }
}
