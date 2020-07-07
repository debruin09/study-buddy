import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_buddy/blocs/similarity_bloc/similarity_bloc.dart';
import 'package:study_buddy/repositories/similarity_repository.dart';
import 'package:study_buddy/routes/router.gr.dart';
import 'package:study_buddy/injection.dart';
import 'package:study_buddy/ui/shared/theme.dart';

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SimilarityBloc>(
      create: (_) =>
          SimilarityBloc(repository: locator.get<SimilarityRepository>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: ExtendedNavigator<Router>(
          router: Router(),
        ),
        theme: AppTheme.themeData,
        // initialRoute: Routes.homePage,
        // home: HomePage(),
      ),
    );
  }
}
