import 'package:books/models/book.dart';
import 'package:books/provider/books.dart';
import 'package:books/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:books/components/book_tile.dart';
import 'package:provider/provider.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Books books = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.BOOK_FORM
                );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: books.count,
        itemBuilder: (ctx, i) => BookTile(books.byIndex(i)),
      ),
    );
  }
}
