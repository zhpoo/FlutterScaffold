import 'package:flutter/material.dart';
import 'package:musket/common/toasts.dart';
import 'package:musket/common/utils.dart';
import 'package:musket/route/routes.dart';
import 'package:musket/widget/button.dart';
import 'package:musket/widget/dialogs.dart';
import 'package:musket/widget/text_button.dart';
import 'package:musket/widget/text_input.dart';
import 'package:musket/widget/title_bar.dart';
import 'package:musket_app/assets/resources.dart';
import 'package:musket_app/common/user.dart';
import 'package:musket_app/models/sign_in_model.dart';
import 'package:musket_app/network/api_manager.dart';
import 'package:musket_app/route/me/widget/logo_name.dart';
import 'package:musket_app/route/route_auguments.dart';
import 'package:musket_app/util/errors.dart';

class MeLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeLoginPageState();
}

class _MeLoginPageState extends State<MeLoginPage> {
  TextEditingController idController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var strings = R.string;
    return Scaffold(
      appBar: TitleBar.withBack(
        context: context,
        title: strings.meLogin,
        right: GestureDetector(
          onTap: toSignUp,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: R.dimen.commonMargin),
            child: Text(strings.meSignUp, style: R.style.linkText.copyWith(fontSize: 16)),
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => clearFocus(context),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                LogoName(),
                TextInputWidget(
                  margin: EdgeInsets.symmetric(horizontal: R.dimen.commonMargin).copyWith(top: 32),
                  label: strings.meLoginId,
                  hint: strings.meLoginId,
                  controller: idController,
                  hintStyle: R.style.tertiaryText.copyWith(fontSize: 20),
                  style: R.style.primaryText.copyWith(fontSize: 20),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: R.color.border,
                      width: R.dimen.borderWidth,
                    ),
                  ),
                ),
                TextInputWidget(
                  margin: EdgeInsets.all(R.dimen.commonMargin).copyWith(top: 32),
                  label: strings.meLoginPassword,
                  hint: strings.meLoginPassword,
                  hintStyle: R.style.tertiaryText.copyWith(fontSize: 20),
                  style: R.style.primaryText.copyWith(fontSize: 20),
                  controller: passwordController,
                  obscureText: true,
                ),
                Button(
                  text: strings.meLogin,
                  onTap: login,
                  margin: EdgeInsets.all(R.dimen.commonMargin),
                ),
                TextButton(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: R.dimen.commonMargin),
                  onPress: () => Toasts.show(msg: 'not implement yet!'),
                  text: strings.meLoginForgetPassword,
                  color: R.color.linkText,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    String id = idController.text;
    if (id.isEmpty) {
      Errors.toastContentEmpty(context, R.string.meLoginId);
      return;
    }
    String password = passwordController.text;
    if (password.isEmpty) {
      Errors.toastContentEmpty(context, R.string.meLoginPassword);
      return;
    }
    Dialogs.showLoading(context);

    var email = id;

    void onSignInSuccess(SignInModel signInModel, resultData) async {
      if (signInModel.code == successCode) {
        await User().onLogin(signInModel.data);
        Routes.pop(context); // dismiss loading dialog
        Routes.pop(context, true); // 返回true：登录成功标志
      } else {
        Routes.pop(context); // dismiss loading dialog
      }
    }

    void onSignInFailed(resultData) {
      Routes.pop(context); // dismiss loading dialog
    }

    ApiManager.signIn(
      email: email,
      password: password,
      onSuccess: onSignInSuccess,
      onFailed: onSignInFailed,
    );
  }

  void toSignUp() async {
    if (isRouteFrom(Routes.getArguments(context), SourcePage.signUp)) {
      Routes.pop(context);
    } else {
      // TODO: to sign up
      Toasts.show(msg: 'not implement yet!');
    }
  }
}
