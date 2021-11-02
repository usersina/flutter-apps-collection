import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http_books_explorer/data/http_helper.dart';
import 'package:http_books_explorer/models/book.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final HttpHelper _helper = HttpHelper();
  bool isError = false;

  List<Book> books = [];

  late bool isLargeScreen;

  @override
  void initState() {
    super.initState();
    // addMenuBar();
    getTheBooks();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }

    return isError
        ? const Center(
            child: Text("An unexpected error has occured!"),
          )
        : GridView.count(
            childAspectRatio: isLargeScreen ? 8 : 5,
            crossAxisCount: isLargeScreen ? 2 : 1,
            children: List.generate(
              books.length,
              (idx) {
                Book myBook = books[idx];
                return ListTile(
                  title: Text(myBook.title),
                  subtitle: Text(myBook.authors),
                  leading: CircleAvatar(
                    backgroundImage: (myBook.thumbnail) == ''
                        ? null
                        : NetworkImage(myBook.thumbnail),
                  ),
                );
              },
            ),
          );
  }

  Future getTheBooks() async {
    try {
      List<Book> myBooks = await _helper.getBooks('flutter');
      log(myBooks.toString());

      setState(() {
        books = myBooks;
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        isError = true;
      });
    }
  }
}
