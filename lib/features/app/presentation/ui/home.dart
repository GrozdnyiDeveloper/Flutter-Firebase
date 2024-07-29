import 'package:firebase_app/features/app/presentation/widget/bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBar(title: 'Главная страница',),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/login');
              }, 
              child: Text("Авторизация", style: TextStyle(fontSize: 16)),
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue))
            ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/registration');
              }, 
              child: Text("Регистрация", style: TextStyle(fontSize: 16)),
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
            ),
          ],
        ),
      )
    );
  }
}
