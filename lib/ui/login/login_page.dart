import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    super.initState();
    setState(()=>
      this._user = widget._loginBloc.firebaseAuth.currentUser
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusText = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(_user == null
          ? 'You are not logged in.'
          : 'You are logged in as "${_user.displayName}".'),
    );
    final googleLoginBtn = MaterialButton(
      color: Colors.blueAccent,
      child: Text('Log in with Google'),
      onPressed: this._busy
      ? null
      : () async {
        setState(() => this._busy = true);
        await this._googleSignIn();
        widget._loginBloc.saveUserData(_user);
        Navigator.pop(context);
        setState(()=> this._busy = false);
      },
    );

    final currentUserBtn = MaterialButton(
      color: Colors.grey,
      child: Text('My account'),
      onPressed: () => this._showUserProfilePage(this._user)
    );
    final signOutBtn = TextButton(
      child: Text('Log out'),
      onPressed: this._busy
        ? null
        : () async {
        setState(()=> this._busy = true);
        await this._signOut();
        setState(()=> this._busy = false);
      },
    );

    var widgetsList = _user == null
      ? <Widget>[
        statusText,
        googleLoginBtn,
    ] : <Widget>[
        statusText,
        currentUserBtn,
        signOutBtn
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:ListView(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          children: widgetsList
        )
      )
    );
  }

  Future<User> _googleSignIn() async {
    final curUser = this._user ?? widget._loginBloc.firebaseAuth.currentUser;
    if(curUser != null && !curUser.isAnonymous){
      setState(()=> this._user = curUser);
      return curUser;
    }

     final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    final user = await widget
        ._loginBloc
        .firebaseAuth
        .signInWithCredential(credential);
    setState(()=> this._user = user.user);
    return user.user;
  }

  Future<Null> _signOut() async {
    widget._loginBloc.firebaseAuth..signOut();
    setState(() =>this._user = null);
  }

  void _showUserProfilePage(User user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            title: Text('user profile'),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(title: Text('User id: ${user.uid}')),
              ListTile(title: Text('Display name: ${user.displayName}')),
              ListTile(title: Text('Anonymous: ${user.isAnonymous}')),
              ListTile(title: Text('Email: ${user.email}')),
              ListTile(
                title: Text('Profile photo: '),
                trailing: user.photoURL != null
                  ? CircleAvatar(backgroundImage: NetworkImage(user.photoURL))
                    : CircleAvatar(
                  child: Text(user.displayName[0])
                )
              ),
              ListTile(title: Text('User id: ${user.uid}')),
              ListTile(
                title: Text(
                    'Last sign in: ${DateTime.fromMillisecondsSinceEpoch(user.metadata.lastSignInTime.millisecondsSinceEpoch)}'),
              ),
              ListTile(
                title: Text(
                    'Creation time: ${DateTime.fromMillisecondsSinceEpoch(user.metadata.creationTime.millisecondsSinceEpoch)}'),
              ),
            ]
          )
        )
      )
    );
  }
}