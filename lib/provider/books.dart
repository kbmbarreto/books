import 'dart:math';

import 'package:books/data/books.dart';
import 'package:books/models/book.dart';
import 'package:flutter/material.dart';

class Books with ChangeNotifier {
  final Map<String, Book> _items = {...BOOKS};

  List<Book> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Book byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Book book) {
    if (book == null) {
      return;
    }

    if (book.id != null &&
        book.id.trim().isNotEmpty &&
        _items.containsKey(book.id)) {
      _items.update(
          book.id,
          (_) => Book(
              id: book.id,
              title: book.title,
              author: book.author,
              photoUrl: book.photoUrl));
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
          id,
          () => Book(
                id: id,
                title: book.title,
                author: book.author,
                photoUrl: book.photoUrl,
              ));
    }
    notifyListeners();
  }

  void remove(Book book) {
    if (book != null && book.id != null) {
      _items.remove(book.id);
      notifyListeners();
    }
  }
}
