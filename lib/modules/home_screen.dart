import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/modules/login.dart';
import 'package:my_test_shop/modules/search_screen.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_cubit.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_states.dart';
import 'package:my_test_shop/shared/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:  (BuildContext context) => HomeCubit()..getHomeData()..getCategories()..getFavorites()..getUser(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeBottomNavBar(index);

                
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
            appBar: AppBar(
              title: Text('Shop App'),

              actions: [
                IconButton(
                    onPressed: () {
                      
                      // CacheHelper.deleteData(key: 'token').then((value) {
                      //   if(value){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SearchScreen()),
                            );
                        //}
                      // });
                    },
                    icon: Icon(Icons.search))
              ],
            ),
          );
        },
      ),
    );
  }
}



//  bottomNavigationBar: CurvedNavigationBar(
//     backgroundColor: Colors.blueAccent,
//     items: <Widget>[
//       Icon(Icons.add, size: 30),
//       Icon(Icons.list, size: 30),
//       Icon(Icons.compare_arrows, size: 30),
//     ],
//     onTap: (index) {
//       //Handle button tap
//     },
//   ),