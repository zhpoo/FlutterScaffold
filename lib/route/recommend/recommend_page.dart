import 'package:flutter/material.dart';
import 'package:musket/common/utils.dart';
import 'package:musket/widget/indicator_stack.dart';
import 'package:musket/widget/no_record.dart';
import 'package:musket/widget/title_bar.dart';
import 'package:musket_app/assets/resources.dart';

class RecommendPage extends StatefulWidget {
  final bool isVisible;

  const RecommendPage({this.isVisible, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    postFrameCallback(getDataFromSever);
  }

  @override
  void didUpdateWidget(RecommendPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      getDataFromSever();
    }
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
      appBar: TitleBar.text(text: R.string.mainRecommend),
      body: IndicatorStack(
        showIndicator: isLoading,
        child: NoRecord(),
      ),
    );
  }
}
