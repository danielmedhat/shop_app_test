
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/models/login_model.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/login_states.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/register_cubit/register_states.dart';
import 'package:my_test_shop/shared/entry_point.dart';
import 'package:my_test_shop/shared/network/romote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterinitState());
   bool isVisable=true;
  static RegisterCubit get(contaxt) => BlocProvider.of(contaxt);
  LoginModel loginModel;
  void userRegister({@required String email,
   @required String password,
   @required String phone,
   @required String name,

   }) {
    emit(RegisterLoadingState());
    DioHelper.postData(data: {'email': email, 'password': password,'name':name,'phone':phone
    }, url: REGISTER)
        .then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(RegistererrorState());
    });
  }
   void changeVisabilety() {
    isVisable = !isVisable;
    emit(RegisterChangeVisabilityState());
  }
}
