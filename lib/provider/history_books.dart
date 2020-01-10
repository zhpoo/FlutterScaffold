import 'package:flutter/cupertino.dart';
import 'package:musket_app/models/book.dart';

class HistoryBooks with ChangeNotifier {
  static HistoryBooks _singleton;

  HistoryBooks._();

  factory HistoryBooks() {
    _singleton ??= HistoryBooks._();
    return _singleton;
  }

  List<Book> _value = [];

  List<Book> get value => _value;

  void clear() => setValue(null);

  Future<void> setValue(List<Book> books) async {
    _value = books;
    notifyListeners();
  }
}
