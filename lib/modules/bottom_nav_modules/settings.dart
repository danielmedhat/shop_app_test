import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/modules/login.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_states.dart';
import 'package:my_test_shop/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! HomeLoadingFavorites,
          builder: (context) => settingsBuilder(context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget settingsBuilder(context) {
    return SingleChildScrollView(
      child:  Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person,size: 60,),
            ),
            SizedBox(
              height: 30,
            ),
            Text('${HomeCubit.get(context).userModel.data.name}',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,

            ),),
            SizedBox(
              height: 30,
            ),
            Text('${HomeCubit.get(context).userModel.data.email}',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.grey[600]
            ),),
            SizedBox(
              height: 30,
            ),
            Text('${HomeCubit.get(context).userModel.data.phone}',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.grey[600]
            ),),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
               CacheHelper.deleteData(key: 'token').then((value) {
                        if(value){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                            (route) => false);
                        }
                      });
            },
             child:Text('Log out') )

          ],
        ),
      ),
    );
  }
}
