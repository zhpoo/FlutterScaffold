import 'package:flutter/material.dart';
import 'package:musket/widget/no_record.dart';
import 'package:musket/widget/title_bar.dart';
import 'package:musket_app/assets/resources.dart';
import 'package:musket_app/common/config.dart';
import 'package:musket_app/provider/favorite_books.dart';
import 'package:musket_app/provider/history_books.dart';
import 'package:provider/provider.dart';

class BookshelfPage extends StatefulWidget {
  const BookshelfPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookshelfPageState();
}

class _BookshelfPageState extends State<BookshelfPage> with SingleTickerProviderStateMixin {
  List<String> tabs = [];
  TabController controller;

  @override
  void initState() {
    super.initState();
    tabs.length = 2;
    controller = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Config.listen(context);
    tabs = [
      R.string.bookFavorite,
      R.string.bookshelfHistory,
    ];
    return Scaffold(
      appBar: TitleBar(
        title: TabBar(
          isScrollable: true,
          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          controller: controller,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: R.color.accent,
          labelColor: R.color.accent,
          unselectedLabelColor: R.color.primaryText,
          indicatorWeight: 3,
          labelStyle: R.style.boldText.copyWith(fontSize: 18, color: R.color.accent),
          unselectedLabelStyle: R.style.boldText.copyWith(fontSize: 18),
          indicatorPadding: EdgeInsets.only(bottom: 8),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          ChangeNotifierProvider<FavoriteBooks>.value(
            value: FavoriteBooks(),
            child: _Favorite(),
          ),
          ChangeNotifierProvider<HistoryBooks>.value(
            value: HistoryBooks(),
            child: _History(),
          ),
        ],
      ),
    );
  }
}

class _Favorite extends StatelessWidget {
  const _Favorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoRecord();
  }
}

class _History extends StatelessWidget {
  const _History({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoRecord();
  }
}
