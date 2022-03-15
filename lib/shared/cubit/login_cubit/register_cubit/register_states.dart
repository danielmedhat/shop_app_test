import 'package:my_test_shop/models/login_model.dart';

abstract class RegisterStates {}
class RegisterChangeVisabilityState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterinitState extends RegisterStates {}

class RegistererrorState extends RegisterStates {}
