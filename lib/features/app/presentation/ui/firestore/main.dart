import 'package:firebase_app/features/app/domain/cubit/book_cubit.dart';
import 'package:firebase_app/features/app/domain/entity/book.dart';
import 'package:firebase_app/features/app/presentation/widget/alert.dart';
import 'package:firebase_app/features/app/presentation/widget/card.dart';
import 'package:firebase_app/features/app/presentation/widget/bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MainPageFirestore extends StatelessWidget {
  const MainPageFirestore({super.key});
  
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: CustomAppBar(title: ('${auth.currentUser!.email}'),),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) => switch(state) {
          BookInitial() || BookLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          BookSuccess() => Column(
            children: [
              StreamBuilder(
                stream: context.read<BookCubit>().getBooks(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs.map((doc) {
                          return BookCard(book: Book(id: doc.id, title: doc.data()['title'], author: doc.data()['author'], description: doc.data()['description']));
                        }).toList()
                      )
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/create');
                }, 
                child: const Text('Создать',),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/files');
                }, 
                child: const Text('Перейти в хранилище',),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange)),
              ),
            ],
          ),
          BookError() => ErrorAlert(text: context.read<BookCubit>().getError),
        }
      ),
    );
  }
}
