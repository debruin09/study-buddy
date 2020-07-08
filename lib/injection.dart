import 'package:get_it/get_it.dart';
import 'package:study_buddy/blocs/next_card_bloc/next_card_bloc.dart';
import 'package:study_buddy/mock/mock_api_service.dart';
import 'package:study_buddy/mock/mock_auth_service.dart';
import 'package:study_buddy/mock/mock_database_service.dart';
import 'package:study_buddy/blocs/card_bloc/card_entity_bloc.dart';
import 'package:study_buddy/blocs/deck_bloc/deck_bloc.dart';
import 'package:study_buddy/blocs/similarity_bloc/similarity_bloc.dart';
import 'package:study_buddy/models/deck.dart';
import 'package:study_buddy/models/similarity_check.dart';
import 'package:study_buddy/models/study_model.dart';
import 'package:study_buddy/repositories/auth_repository.dart';
import 'package:study_buddy/repositories/database_repository.dart';
import 'package:study_buddy/repositories/similarity_repository.dart';
import 'package:study_buddy/repositories/tag_repository.dart';
import 'package:study_buddy/services/local_notification_service.dart';
import 'package:study_buddy/services/tag_service.dart';
// import 'package:study_buddy/src/services/auth_service.dart';
// import 'package:study_buddy/src/services/firestore_service.dart';
// import 'package:study_buddy/src/services/similarity_api_service.dart';

final locator = GetIt.instance;

const USE_FAKE_IMPLEMENTATION = true;

void setupLocator() {
  /// [Blocs]
  locator.registerFactory<SimilarityBloc>(
      () => SimilarityBloc(repository: locator()));

  locator.registerLazySingleton<CardEntityBloc>(
      () => CardEntityBloc(repository: locator()));

  locator
      .registerLazySingleton<DeckBloc>(() => DeckBloc(repository: locator()));

  locator.registerLazySingleton<NextCardBloc>(
      () => NextCardBloc(databaseRepository: locator()));

  ///[Repositories]
  locator.registerLazySingleton<SimilarityRepository>(() => MockApiService());
  // USE_FAKE_IMPLEMENTATION ? MockApiService() : SimilarityApiService());

  locator.registerLazySingleton<DatabaseRepository>(
      () => MockDatabaseService(myuid: "locator()"));
  // USE_FAKE_IMPLEMENTATION
  //     ? MockDatabaseService(myuid: locator())
  //     : FirestoreService(myuid: locator()));

  /// [Services]
  locator.registerLazySingleton<TagRepository>(() => TagService());

  /// Local Notification
  locator.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());

  locator.registerLazySingleton<AuthRepository>(() => MockAuthService());
  // USE_FAKE_IMPLEMENTATION ? MockAuthService() : AuthService());

  ///[Models]
  /// Similarity check
  locator.registerFactory<SimilarityCheck>(() => SimilarityCheck());

  /// Study model , models the frame of the app
  locator.registerFactory<StudyModel>(() => StudyModel());

  locator.registerFactory<Deck>(() => Deck());
}
