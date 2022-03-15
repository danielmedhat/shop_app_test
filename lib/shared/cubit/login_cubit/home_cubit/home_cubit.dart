import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/models/categories_model.dart';
import 'package:my_test_shop/models/change_favorites_model.dart';
import 'package:my_test_shop/models/favorites_model.dart';
import 'package:my_test_shop/models/home_model.dart';
import 'package:my_test_shop/models/user_model.dart';
import 'package:my_test_shop/modules/bottom_nav_modules/categories.dart';
import 'package:my_test_shop/modules/bottom_nav_modules/favorites.dart';
import 'package:my_test_shop/modules/bottom_nav_modules/products.dart';
import 'package:my_test_shop/modules/bottom_nav_modules/settings.dart';
import 'package:my_test_shop/shared/components/constans/constans.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/home_cubit/home_states.dart';
import 'package:my_test_shop/shared/entry_point.dart';
import 'package:my_test_shop/shared/network/romote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  List<Widget> bottomScreens = [
    ProductsScreen(),
    FavoritesScreen(),
    CategoriesScreen(),
    SettingsScreen()
  ];

  HomeCubit() : super(HomeInitState());
  static HomeCubit get(contaxt) => BlocProvider.of(contaxt);
  int currentIndex = 0;
 

  void changeBottomNavBar(int index) {
    currentIndex = index;
    print(index);
    emit(ChangeBottomNavBarState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(HomeLoadindGetData());
    DioHelper.getDta(url: HOME, token: token).then((value) {
      print(token);
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel.data.banners[3].image);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorite});
      });
      print(favorites.toString());

      emit(HomeSuccessGetData());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetData());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(HomeChangeFavorites());

    DioHelper.postData(
            data: {'product_id': productId}, token: token, url: FAVORITES)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel.status == false) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }

      // print(changeFavoritesModel.status.toString());

      emit(HomeSuccessChangeFavorites());
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId];
      emit(HomeErrorChangeFavorites());
    });
  }

  CategoriesModel categoriesModel;
  void getCategories() {
    DioHelper.getDta(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(homeModel.data.banners[3].image);

      emit(HomeSuccessCategories());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorCategories());
    });
  }

  UserModel userModel;
  void getUser() {
    emit(HomeLoadingUser());
    DioHelper.getDta(url: PROFILE, token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel.data.phone);

      emit(HomeSuccessUser());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetUser());
    });
  }

 

  FavoritesModel favoritesModel;
  void getFavorites() {
    emit(HomeLoadingFavorites());
    DioHelper.getDta(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // print(value.data.toString());
      // print(homeModel.data.banners[3].image);

      emit(HomeSuccessFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorFavorites());
    });
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    //print(event);
  }
}
