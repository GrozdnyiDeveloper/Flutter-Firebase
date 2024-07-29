import 'package:firebase_app/features/app/domain/cubit/book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ошибка'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(text),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ок'),
          onPressed: () {
            context.read<BookCubit>().init();
          },
        ),
      ],
    );
  }
}