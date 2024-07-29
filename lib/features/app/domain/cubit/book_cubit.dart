import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/app/domain/entity/book.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  final fireStore = FirebaseFirestore.instance;
  final collection = FirebaseFirestore.instance.collection("book");

  final imagesRef = FirebaseStorage.instance.ref().child("images");
  List<String> files = [];

  String _lastError = "";
  String get getError => _lastError;

  Book book = Book(title: "", author: "");

  void init() {
    try {
      emit(BookLoading());
      getImages();
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBooks() {
    Stream<QuerySnapshot<Map<String, dynamic>>> result = const Stream.empty();
    try {
      emit(BookLoading());
      result = collection.snapshots();
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
    return result;
  }

  void addBook(Book book) async {
    try {
      emit(BookLoading());
        Map<String, dynamic> map = {
        "title": book.title,
        "author": book.author,
        "description": book.description
      };
      await collection.add(map);
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void updateBook(String index, Book book) async {
    try {
      emit(BookLoading());
        Map<String, dynamic> map = {
        "title": book.title,
        "author": book.author,
        "description": book.description
      };
      await collection.doc(index).set(map);
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void deleteBook(String index) async {
    try {
      emit(BookLoading());
      await collection.doc(index).delete();
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void getImages() async {
    files = [];
    await imagesRef.listAll().then((value) =>
      value.items.forEach((element) { 
        files.add(element.fullPath);
      })
    );
  }

  void addImage(File file) async {
    try {
      emit(BookLoading());
      await imagesRef.child(basename(file.path)).putFile(file);
      getImages();
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void deleteImage(String path) async {
    try {
      emit(BookLoading());
      await FirebaseStorage.instance.ref().child(path).delete();
      getImages();
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }
}
