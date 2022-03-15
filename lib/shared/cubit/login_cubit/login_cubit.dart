
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/models/login_model.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/login_states.dart';
import 'package:my_test_shop/shared/entry_point.dart';
import 'package:my_test_shop/shared/network/romote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LogininitState());
   bool isVisable=true;
  static LoginCubit get(contaxt) => BlocProvider.of(contaxt);
  LoginModel loginModel;
  void userLogin({@required String email, @required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(data: {'email': email, 'password': password}, url: LOGIN)
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginerrorState());
    });
  }
   void changeVisabilety() {
    isVisable = !isVisable;
    emit(ChangeVisabilityState());
  }
}
