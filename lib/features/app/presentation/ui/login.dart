import 'dart:developer';

import 'package:firebase_app/features/app/presentation/widget/alert.dart';
import 'package:firebase_app/features/app/presentation/widget/bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Страница авторизации',),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Почта", enabledBorder: UnderlineInputBorder()),
            controller: email,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Пароль", enabledBorder: UnderlineInputBorder()),
            controller: password,
          ),
          ElevatedButton(
            onPressed: () async {
              final auth = FirebaseAuth.instance;
              try {
                await auth.signInWithEmailAndPassword(
                  email: email.text, 
                  password: password.text
                );
                Navigator.pushNamed(context, '/main');
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ErrorAlert(text: e.toString());
                  }
                );
                log(e.toString());
              }
            },
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
            child: const Text(
              'Авторизоваться',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )
    );
  }
}
