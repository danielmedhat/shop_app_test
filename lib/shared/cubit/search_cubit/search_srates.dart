import 'package:my_test_shop/models/login_model.dart';
import 'package:my_test_shop/models/search_model.dart';

abstract class SearchStates {}
//class ChangeVisabilityState extends LoginStates{}
class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final SearchModel searchModel;

 SearchSuccessState(this.searchModel);
}

class SearchinitState extends SearchStates {}

class SearcherrorState extends SearchStates {}
