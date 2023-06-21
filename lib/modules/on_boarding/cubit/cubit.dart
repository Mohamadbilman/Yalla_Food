import 'package:Yalla_Food/layout/layout.dart';
import 'package:Yalla_Food/modules/on_boarding/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/onBoardModel.dart';
import '../../../shared/component.dart';
import '../../../shared/network/local/cache_helper.dart';

class on_boardingCubit extends Cubit<on_boarding_States> {
  on_boardingCubit() : super(speciesinitialState());

  static on_boardingCubit get(context) => BlocProvider.of(context);

  void submit(context) {
    CacheHelper.saveData('onBoarding', true).then((value) {
      if (value!) {
        navigateAndFinish(context, const Shop_layout());
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<OnBoardModel> boarding = [
    OnBoardModel(
      image: 'assets/images/onBoard.png',
      title: 'مرحباً بك في تطبيق يلا food',
      body: 'On Board Body 1 ',
    ),
    OnBoardModel(
        image: 'assets/images/onBoard2.png',
        title: 'مرحباً بك في تطبيق يلا food',
        body: 'On Board Body 2 '),
    OnBoardModel(
        image: 'assets/images/onBoard3.png',
        title: 'مرحباً بك في تطبيق يلا food',
        body: 'On Board Body 3 '),
  ];

  bool? isLast = false;

  void pageChanged({required int index}) {
    if (index == boarding.length - 1) {
      isLast = true;
      emit(is_last());
    } else {
      isLast = false;
      emit(is_not_last());
    }
  }

  void floatFunction(context, {required controller}) {
    if (isLast!) {
      submit(context);
      emit(is_last());
    } else {
      controller.nextPage(
          duration: const Duration(milliseconds: 750),
          curve: Curves.fastLinearToSlowEaseIn);
      emit(is_not_last());
    }
  }
}
