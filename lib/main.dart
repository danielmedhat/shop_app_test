import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_test_shop/modules/home_screen.dart';
import 'package:my_test_shop/modules/login.dart';
import 'package:my_test_shop/modules/on_boarding.dart';
import 'package:my_test_shop/shared/components/constans/constans.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_cubit.dart';
import 'package:my_test_shop/shared/network/local/cache_helper.dart';
import 'package:my_test_shop/shared/network/romote/dio_helper.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.inti();
  await CacheHelper.init();
  bool closeBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget widget;

  token = CacheHelper.getData(key: 'token');
  if (closeBoarding != null) {
    if (token != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  print(closeBoarding);

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: startWidget,
      theme: ThemeData(
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
          ),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0.0,
              actionsIconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark))),
    );
  }
}
