import 'package:firebase_app/features/app/domain/cubit/book_cubit.dart';
import 'package:firebase_app/features/app/domain/entity/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          book.title
        ),
        children: [
          Text(
            "Автор: " + book.author,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Описание: " + book.description,
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<BookCubit>().book = book;
              await Navigator.pushNamed(context, '/edit');
            },
            child: Text("Изменить", style: TextStyle(fontSize: 16),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange) 
            )
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<BookCubit>().deleteBook(book.id);
            },
            child: Text("Удалить", style: TextStyle(fontSize: 16),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red) 
            )
          )
        ],
      )
    );
  }
}