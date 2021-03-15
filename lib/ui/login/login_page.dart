import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:session/common/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(this._loginBloc, {Key key, this.title}) : super(key: key);

  final LoginBloc _loginBloc;
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User _user;
  bool _busy = false;


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}