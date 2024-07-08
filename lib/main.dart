import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kro_banking/app.dart';
import 'package:kro_banking/firebase_options.dart';
import 'package:kro_banking/injection.dart';
import 'package:kro_banking/observer/bloc_observer.dart';
import 'package:kro_banking/router/router.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorage.webStorageDirectory);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  AppRouter.instance;

  configureInjection();

  runApp(const App());
}
