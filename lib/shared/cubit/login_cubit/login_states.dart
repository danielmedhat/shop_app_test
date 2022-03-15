import 'package:my_test_shop/models/login_model.dart';
import 'package:my_test_shop/models/search_model.dart';

abstract class LoginStates {}
class ChangeVisabilityState extends LoginStates{}
class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LogininitState extends LoginStates {}

class LoginerrorState extends LoginStates {}
