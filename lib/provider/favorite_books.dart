import 'package:flutter/cupertino.dart';
import 'package:musket_app/models/book.dart';

class FavoriteBooks with ChangeNotifier {
  static FavoriteBooks _singleton;

  FavoriteBooks._();

  factory FavoriteBooks() {
    _singleton ??= FavoriteBooks._();
    return _singleton;
  }

  List<Book> _value = [];

  List<Book> get value => _value;

  set value(List<Book> books) {
    _value = books;
    notifyListeners();
  }

  void clear() => value = null;

  bool contains(Book book) {
    return _value?.any((item) => item == book) ?? false;
  }
}
