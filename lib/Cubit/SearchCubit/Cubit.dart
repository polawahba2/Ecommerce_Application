import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ClassModel/SearchModel.dart';
import 'package:shop_app/Components/Constants.dart';
import 'package:shop_app/DioHelper.dart';
import 'package:shop_app/Networks/EndPoints.dart';

import 'States.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit getCubit(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      emit(ShopSearchSuccessState());

      searchModel = SearchModel.fromJson(value.data);
      // print(searchModel!.data);
    }).catchError((error) {
      emit(ShopSearchErrorState(error.toString()));
    });
  }
}
