import 'package:flutter/widgets.dart';
import 'package:memoir/views/login/login.dart';
import 'package:memoir/views/login/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();

  static LoginPageState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LoginPageAncestor>()!
        .state;
  }
}

class LoginPageState extends State<LoginPage> {
  bool isLogin = false;
  void setMode(bool isLogin) {
    setState(() {
      this.isLogin = isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageAncestor(
        state: this, child: isLogin ? const LoginForm() : const RegisterForm());
  }
}

class LoginPageAncestor extends InheritedWidget {
  final LoginPageState state;
  const LoginPageAncestor(
      {super.key, required this.state, required super.child});

  @override
  bool updateShouldNotify(covariant LoginPageAncestor oldWidget) {
    return oldWidget.state.isLogin != state.isLogin;
  }
}
