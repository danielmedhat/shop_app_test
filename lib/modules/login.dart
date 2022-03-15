import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/modules/home_screen.dart';
import 'package:my_test_shop/shared/components/constans/constans.dart';
import 'package:my_test_shop/shared/components/custom_textfield.dart';
import 'package:my_test_shop/shared/components/cutsom_logo.dart';
import 'package:my_test_shop/modules/signup.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/login_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/login_states.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_test_shop/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var passControl = TextEditingController();
  var emailControl = TextEditingController();
  static String id = 'LoginScreen';
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.putData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                if (value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                }
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.lightBlueAccent,
              body: Form(
                key: loginKey,
                child: ListView(children: <Widget>[
                  CustomLogo(),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  CustomTextField(
                    visable: false,
                      controller: emailControl,
                      hint: 'Email',
                      icon: Icons.email,
                      validatorT: 'email mustn\'t be empty',
                      type: TextInputType.emailAddress),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  CustomTextField(
                      onClick: () {
                        LoginCubit.get(context).changeVisabilety();
                      },
                      visable: LoginCubit.get(context).isVisable,
                      controller: passControl,
                      hint: 'Password',
                      icon: Icons.lock,
                      validatorT: 'password mustn\'t be empty',
                      type: TextInputType.visiblePassword,
                      passIcon: LoginCubit.get(context).isVisable?Icons.visibility_off :Icons.visibility),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: ConditionalBuilder(
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      condition: (state is! LoginLoadingState),
                      builder: (context) => RaisedButton(
                        onPressed: () {
                          if (loginKey.currentState.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailControl.text,
                                password: passControl.text);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70)),
                        color: Colors.black,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account ? ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  )
                ]),
              ));
        },
      ),
    );
  }
}
