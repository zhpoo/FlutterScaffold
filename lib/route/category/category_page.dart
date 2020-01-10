import 'package:flutter/material.dart';
import 'package:musket/common/utils.dart';
import 'package:musket/widget/indicator_stack.dart';
import 'package:musket/widget/no_record.dart';
import 'package:musket/widget/title_bar.dart';
import 'package:musket_app/assets/resources.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    postFrameCallback(getDataFromSever);
  }

  @override
  void didUpdateWidget(CategoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> getDataFromSever() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.text(text: R.string.mainCategory),
      body: IndicatorStack(
        showIndicator: isLoading,
        child: NoRecord(),
      ),
    );
  }
}
