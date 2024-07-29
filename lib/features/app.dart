import 'package:firebase_app/features/app/domain/cubit/book_cubit.dart';
import 'package:firebase_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<BookCubit>(
          create: (BuildContext context) => BookCubit()..init()
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name == Pages.home.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.home.screen as Widget,
            );
          }
          else if (settings.name == Pages.login.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.login.screen as Widget,
            );
          }
          else if (settings.name == Pages.registration.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.registration.screen as Widget,
            );
          }
          else if (settings.name == Pages.main.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.main.screen as Widget,
            );
          }
          else if (settings.name == Pages.create.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.create.screen as Widget,
            );
          }
          else if (settings.name == Pages.edit.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.edit.screen as Widget,
            );
          }
          else if (settings.name == Pages.files.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.files.screen as Widget,
            );
          }
          return null;
        },
        theme: ThemeData(useMaterial3: false),
        home: Pages.home.screen as Widget,
      ),
    );
  }
}