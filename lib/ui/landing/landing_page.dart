import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:session/common/bloc/login_bloc.dart';

class LandingPage extends StatelessWidget {
  final LoginBloc _loginBloc;

  LandingPage(this._loginBloc, {Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    _loginBloc.getCurrentUID().then((uid) {
      if (uid != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}