import 'package:firebase_app/features/app/domain/cubit/book_cubit.dart';
import 'package:firebase_app/features/app/domain/entity/book.dart';
import 'package:firebase_app/features/app/presentation/widget/alert.dart';
import 'package:firebase_app/features/app/presentation/widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController(text: context.read<BookCubit>().book.title);
    TextEditingController author = TextEditingController(text: context.read<BookCubit>().book.author);
    TextEditingController description = TextEditingController(text: context.read<BookCubit>().book.description);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Изменение книги',),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) => switch(state) {
          BookInitial() || BookLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          BookSuccess() => Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Название",enabledBorder: UnderlineInputBorder()),
                controller: title,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Автор",enabledBorder: UnderlineInputBorder()),
                controller: author,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Описание",enabledBorder: UnderlineInputBorder()),
                controller: description,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (title.text == "" || author.text == "") return;
                  var book = Book(id: context.read<BookCubit>().book.id, title: title.text, description: description.text, author: author.text);
                  context.read<BookCubit>().updateBook(book.id, book);
                  Navigator.pop(context);
                }, 
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Colors.orange),
                ),
                child: Text("Изменить", style: TextStyle(fontSize: 16),)
              )
            ],
          ),
          BookError() => ErrorAlert(text: context.read<BookCubit>().getError),
        },
      ),
    );
  }
}