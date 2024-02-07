import 'package:flutter/material.dart'; // Adicione esta importação
import 'package:books/models/book.dart';
import 'package:books/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../provider/books.dart';

class BookTile extends StatelessWidget {
  final Book book;

  const BookTile(this.book);

  @override
  Widget build(BuildContext context) {
    final image = book.photoUrl == null || book.photoUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.book))
        : CircleAvatar(backgroundImage: NetworkImage(book.photoUrl));

    return ListTile(
      leading: image,
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.BOOK_FORM,
                  arguments: book,
                );
              },
              icon: Icon(Icons.edit),
              color: Colors.orange,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Delete Book'),
                    content: Text('Delete book?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: ()  => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((confirmed) {
                  if(confirmed) {
                    Provider.of<Books>(context, listen: false).remove(book);
                  }
                });
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
