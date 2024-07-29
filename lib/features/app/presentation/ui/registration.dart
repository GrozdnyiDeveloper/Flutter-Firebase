import 'dart:developer';

import 'package:firebase_app/features/app/presentation/widget/alert.dart';
import 'package:firebase_app/features/app/presentation/widget/bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController repeat = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Страница регистрации',),
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
          TextFormField(
            decoration: const InputDecoration(labelText: "Повтор пароля", enabledBorder: UnderlineInputBorder()),
            controller: repeat,
          ),
          ElevatedButton(
            onPressed: () async {
              if (repeat.text == password.text) {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
              } else {
                const ErrorAlert(text: 'Введёные пароли не совпадают');
                log('Введёные пароли не совпадают');
              }
            },
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
            child: const Text(
              'Зарегистрироваться',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )
    );
  }
}
