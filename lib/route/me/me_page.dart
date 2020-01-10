import 'package:flutter/material.dart';
import 'package:musket/common/toasts.dart';
import 'package:musket/musket.dart';
import 'package:musket/route/routes.dart';
import 'package:musket/widget/dialogs.dart';
import 'package:musket/widget/item_text.dart';
import 'package:musket/widget/title_bar.dart';
import 'package:musket_app/assets/app_theme.dart';
import 'package:musket_app/assets/resources.dart';
import 'package:musket_app/common/config.dart';
import 'package:musket_app/common/user.dart';
import 'package:musket_app/route/constants/keys.dart';

class MePage extends StatefulWidget {
  final bool visible;

  const MePage({Key key, this.visible}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  void initState() {
    super.initState();
    User().addListener(onLoginStateChanged);
  }

  @override
  void dispose() {
    User().removeListener(onLoginStateChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(MePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) {
      User().refreshUserProfile();
    }
  }

  void onLoginStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var strings = R.string;
    return Scaffold(
      appBar: TitleBar.text(text: strings.mainMe),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              ItemText(
                icon: R.image.meNightMode,
                text: strings.meNightMode,
                right: Switch.adaptive(value: Config().nightMode, onChanged: onNightModeChanged),
              ),
              ItemText.rightArrow(
                icon: R.image.meSetting,
                text: strings.meSetting,
                onTap: () => User().checkLogin(
                  context,
                  invokeAfterLogin: false,
                  onLoginCallback: () => Toasts.show(msg: 'not implement yet!'),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void onNightModeChanged(bool nightMode) async {
    Dialogs.showLoading(context);
    var sp = await SharedPreferences.getInstance();
    sp.setBool(Keys.settingNightModeSwitch, nightMode);
    Config().setAppTheme(nightMode ? AppTheme.dark : AppTheme.light);
    Routes.pop(context);
  }
}
