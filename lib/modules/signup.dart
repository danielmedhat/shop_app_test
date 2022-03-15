import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_test_shop/modules/home_screen.dart';
import 'package:my_test_shop/shared/components/constans/constans.dart';
import 'package:my_test_shop/shared/components/custom_textfield.dart';
import 'package:my_test_shop/shared/components/cutsom_logo.dart';
import 'package:my_test_shop/modules/login.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/login_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/register_cubit/register_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/register_cubit/register_states.dart';
import 'package:my_test_shop/shared/network/local/cache_helper.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  var nameController=TextEditingController();

    var emailController=TextEditingController();
    
    var phoneController=TextEditingController();
    var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
           if (state is RegisterSuccessState) {
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
                key: signupKey,
                child: ListView(children: <Widget>[
                  CustomLogo(),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  CustomTextField(
                      visable: false,
                      type: TextInputType.name,
                      hint: 'Full Name',
                      icon: Icons.text_fields,
                      controller: nameController,
                      validatorT: 'name mustn\'t be empty'),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  CustomTextField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    hint: 'Email',
                    visable: false,
                    validatorT: 'email mustn\'t be empty',
                    icon: Icons.email,
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    hint: 'Phone',
                    visable: false,
                    validatorT: 'email mustn\'t be empty',
                    icon: Icons.phone,
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  CustomTextField(
                      controller: passwordController,
                      onClick: () {
                        RegisterCubit.get(context).changeVisabilety();
                      },
                      visable: RegisterCubit.get(context).isVisable,
                      //controller: passControl,
                      hint: 'Password',
                      icon: Icons.lock,
                      validatorT: 'password mustn\'t be empty',
                      type: TextInputType.visiblePassword,
                      passIcon: RegisterCubit.get(context).isVisable
                          ? Icons.visibility_off
                          : Icons.visibility),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (signupKey.currentState.validate()) {
                          RegisterCubit.get(context).userRegister(
                              email: (emailController.text.toString()),
                              password: (passwordController.text.toString()),
                              phone: (phoneController.text.toString()),
                              name: (nameController.text.toString()));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70)),
                      color: Colors.black,
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Have an account ? ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            'Login',
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
