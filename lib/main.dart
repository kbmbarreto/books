import 'package:books/provider/books.dart';
import 'package:books/routes/app_routes.dart';
import 'package:books/views/book_form.dart';
import 'package:books/views/book_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Books(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        routes: {
          AppRoutes.HOME: (_) => BookList(),
          AppRoutes.BOOK_FORM: (_) => BookForm()
        },
      ),
    );
  }
}
