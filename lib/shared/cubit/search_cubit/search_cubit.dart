import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_test_shop/models/login_model.dart';
import 'package:my_test_shop/models/search_model.dart';
import 'package:my_test_shop/shared/components/constans/constans.dart';
import 'package:my_test_shop/shared/cubit/login_cubit/login_states.dart';
import 'package:my_test_shop/shared/cubit/search_cubit/search_srates.dart';
import 'package:my_test_shop/shared/entry_point.dart';
import 'package:my_test_shop/shared/network/romote/dio_helper.dart';

class Searchcubit extends Cubit<SearchStates> {
  Searchcubit() : super(SearchinitState());
  bool isVisable = true;
  static Searchcubit get(contaxt) => BlocProvider.of(contaxt);
  SearchModel searchModel;
  void search({@required String text}) {
    emit(SearchLoadingState());
    DioHelper.postData(data: {'text': text},token: token, url: SEARCH).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel.status);
      emit(SearchSuccessState(searchModel));
    }).catchError((error) {
      emit(SearcherrorState());
    });
  }
  
  //  void changeVisabilety() {
  //   isVisable = !isVisable;
  //   emit(ChangeVisabilityState());
  // }
}
