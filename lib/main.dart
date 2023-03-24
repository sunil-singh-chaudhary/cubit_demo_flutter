import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Repo/user_repository.dart';
import 'UserPage.dart';

void main() {
  // Handles Flutter Errors
  FlutterError.onError = (details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      final error = details.exception;
      final stackTrace = details.stack ?? StackTrace.empty;
      Zone.current.handleUncaughtError(error, stackTrace);
    }
  };

  // Handles Dart Errors
  runZonedGuarded<void>(
    () {
      runApp(MyApp(userRepository: UserRepository()));
    },
    (error, stackTrace) {
      debugPrint('Caught Dart Error');

      if (kDebugMode) {
        // In development, print [error] and [stackTrace].
        print(error);
        print(stackTrace);
      } else {
        /// In production, report to an error tracking system.
      }
    },
    zoneSpecification: const ZoneSpecification(),
    zoneValues: {},
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.userRepository});
  UserRepository userRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: userRepository,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserPage(),
      ),
    );
  }
}
