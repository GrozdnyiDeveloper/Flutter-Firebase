import 'package:firebase_app/features/app/presentation/ui/firestore/create.dart';
import 'package:firebase_app/features/app/presentation/ui/firestore/edit.dart';
import 'package:firebase_app/features/app/presentation/ui/firestore/main.dart';
import 'package:firebase_app/features/app/presentation/ui/home.dart';
import 'package:firebase_app/features/app/presentation/ui/login.dart';
import 'package:firebase_app/features/app/presentation/ui/registration.dart';
import 'package:firebase_app/features/app/presentation/ui/storage/images.dart';

enum Pages{
  home,
  login,
  registration,
  main,
  create,
  edit,
  files
}

extension AppPageExtension on Pages {
  String get screenPath {
    return switch (this) {
      Pages.home => '/',
      Pages.login => '/login',
      Pages.registration => '/registration',
      Pages.main => '/main',
      Pages.create => '/create',
      Pages.edit => '/edit',
      Pages.files => '/files',
    };
  }

  Object get screen {
    return switch (this) {
      Pages.home => const HomePage(),
      Pages.login => const LoginPage(),
      Pages.registration => const RegistrationPage(),
      Pages.main => const MainPageFirestore(),
      Pages.create => const CreatePage(),
      Pages.edit => const EditPage(),
      Pages.files => const FilePage(),
    };
  }
}