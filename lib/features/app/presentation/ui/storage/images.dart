import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_app/features/app/domain/cubit/book_cubit.dart';
import 'package:firebase_app/features/app/presentation/widget/alert.dart';
import 'package:firebase_app/features/app/presentation/widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FilePage extends StatelessWidget {
  const FilePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Хранилище',),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) => switch(state) {
          BookInitial() || BookLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          BookSuccess() => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: context.read<BookCubit>().files.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ExpansionTile(
                        title: Text(
                          context.read<BookCubit>().files[index]
                        ),
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              context.read<BookCubit>().deleteImage(context.read<BookCubit>().files[index]);
                            },
                            child: Text("Удалить", style: TextStyle(fontSize: 16),),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.red) 
                            )
                          )
                        ],
                      ),
                    );
                  }
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    context.read<BookCubit>().addImage(File(result.files.single.path!));
                  } 
                }, 
                child: const Text('Загрузить',),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
              ),
            ],
          ),
          BookError() => ErrorAlert(text: context.read<BookCubit>().getError),
        }
      ),
    );
  }
}
