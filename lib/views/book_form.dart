import 'package:flutter/material.dart';
import 'package:books/models/book.dart';
import 'package:books/provider/books.dart';
import 'package:provider/provider.dart';

class BookForm extends StatefulWidget {
  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(Book? book) {
    if (book != null) {
      _formData['id'] = book.id;
      _formData['title'] = book.title;
      _formData['author'] = book.author;
      _formData['photoUrl'] = book.photoUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Book? book = ModalRoute.of(context)?.settings.arguments as Book?;
    _loadFormData(book);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Book'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState?.save();

                Provider.of<Books>(context, listen: false).put(
                  Book(
                    id: _formData['id'] ?? '',
                    title: _formData['title'] ?? '',
                    author: _formData['author'] ?? '',
                    photoUrl: _formData['photoUrl'] ?? '',
                  ),
                );

                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['title'],
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Invalid Title';
                  }
                  if (value.trim().length < 2) {
                    return 'Small name. Minimal: 2 letters.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['title'] = value!,
              ),
              TextFormField(
                initialValue: _formData['author'],
                decoration: InputDecoration(labelText: 'Author'),
                onSaved: (value) => _formData['author'] = value!,
              ),
              TextFormField(
                initialValue: _formData['photoUrl'],
                decoration: InputDecoration(labelText: 'Cover url'),
                onSaved: (value) => _formData['photoUrl'] = value!,
              )
            ],
          ),
        ),
      ),
    );
  }
}