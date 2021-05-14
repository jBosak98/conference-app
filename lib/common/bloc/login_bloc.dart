import 'package:firebase_auth/firebase_auth.dart';
import 'package:session/common/bloc/base_bloc.dart';
import 'package:session/common/repository/user_data_repository.dart';

class LoginBloc extends BaseBloc {
  FirebaseAuth firebaseAuth;

  UserDataRepository _userDataRepository;

  LoginBloc(this.firebaseAuth, this._userDataRepository);

  Stream<User> get onAuthStateChanged => firebaseAuth.authStateChanges();

  Future<String> getCurrentUID() async {
    return firebaseAuth.currentUser?.uid;
  }

  void saveUserData(User user) => _userDataRepository.saveUserData(user);
}