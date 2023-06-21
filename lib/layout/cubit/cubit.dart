import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:Yalla_Food/layout/cubit/states.dart';
import 'package:Yalla_Food/modules/Search/search_screen.dart';
import 'package:Yalla_Food/modules/cart/cart_screen.dart';
import 'package:Yalla_Food/modules/home.dart';

import 'package:Yalla_Food/modules/restaurants/dishes_Screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../abdulrahman/class/appLink.dart';
import '../../model/Home_model.dart';
import '../../model/card.dart';
import '../../model/menuModel.dart';
import '../../model/restaurantModel.dart';
import '../../model/serchModel.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/remote/dio.dart';

class Yalla_Food_Cubit extends Cubit<Yalla_Food_States> {
  Yalla_Food_Cubit() : super(Yalla_Food_InitialState());

  static Yalla_Food_Cubit get(context) => BlocProvider.of(context);
  late int i;
  int currentIndex = 0;
  List<Widget> screen = [
    home_screen(),
    const dishes(),
    search(),
    const Cart_Screen(),
    // const department_screen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Future<void> sendWhatsAppMessage(
      {required String number, required String message}) async {
    final whatsappUrl = 'https://wa.me/$number?text=${Uri.encodeFull(message)}';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  List<String> favTitle = [];
  List<String> favdesc = [];
  List<String> favimage = [];
  List<String> favAddition = [];
  List<bool> favType = [];
  List<String> count = [];
  List<String> favprice = [];
  List<Map<String, dynamic>> favs = [];

  Future<void> addFav({
    required String value,
    required String image,
    required String desc,
    required String add,
    required String price,
    required bool type,
    required String number,
  }) async {
    CacheHelper.saveFavData(
            '${value}favorite', value, image, desc, add, price, type)
        .then((val) {
      favTitle.add(value);
      favprice.add(price);
      favimage.add(image);
      favdesc.add(desc);
      favAddition.add(add);
      count.add(number);
      favType.add(type);
      favs.add({
        "الطلب": value,
        "الوصف": desc,
        "اضافات": add,
        "العدد": number.toString(),
        "النوع": type,
        "السعر": price
      });
      emit(addedToFav());

      print(favs);
    });
  }

  void deleteFav({
    required int index,
  }) {
    favTitle.removeAt(index);
    favdesc.removeAt(index);
    favimage.removeAt(index);
    favs.removeAt(index);
    favType.removeAt(index);
    emit(removedFromFav());

    print(favs);
  }

  void getFav() {
    CacheHelper.getFavData('favorite');
  }

  List<Resturant> restaurant = [];

  Future<void> getRestauranrData() async {
    emit(LoadingRestaurantDataState());
    var responce =
        await HttpData.getData(LinkRestaurant.linkResturant).then((value) {
      List<dynamic> data = value['data'];
      List<Resturant> restaurantData =
          data.map((value) => Resturant.fromJson(value)).toList();

      restaurant = restaurantData;
      emit(SuccessRestaurantDataState());
    }).catchError((error) {
      emit(ErorrRestaurantDataState());
      print("Error $error");
    });
  }

  List<MenuModel> menu = [];

  Future<void> getMenuData() async {
    emit(LoadingMenuDataState());
    var responce =
        await HttpData.getData(LinkRestaurant.linkMenu).then((value) {
      List<dynamic> data = value['data'];
      List<MenuModel> menuData =
          data.map((value) => MenuModel.fromJson(value)).toList();
      menu = menuData;

      emit(SuccessMenuDataState());
    }).catchError((error) {
      emit(ErorrMenuDataState());
      print("Error $error");
    });
  }

  List<MenuModel> menui = [];

  Future<void> getMenuresData(i) async {
    emit(LoadingMenuiDataState());
    var responce = await HttpData.postdata(LinkRestaurant.linkMenui, {"id": i})
        .then((value) {
      List<dynamic> data = value['data'];
      List<MenuModel> menuData =
          data.map((value) => MenuModel.fromJson(value)).toList();
      menui = menuData;

      emit(SuccessMenuiDataState());
    }).catchError((error) {
      emit(ErorrMenuiDataState());
      print("Error $error");
    });
  }

  List<CardModel> card = [];

  Future<void> getCardData() async {
    emit(LoadingMenuiDataState());
    var responce =
        await HttpData.getData(LinkRestaurant.linkViewCaed).then((value) {
      List<dynamic> data = value['data'];
      List<CardModel> cardData =
          data.map((value) => CardModel.fromJson(value)).toList();

      card = cardData;
      emit(SuccessMenuiDataState());
    }).catchError((error) {
      emit(ErorrMenuiDataState());
      print("Error $error");
    });
  }

  List<SearchModel> searchfood = [];

  Future<void> getDataSearch(search) async {
    emit(SearchLoadingState());
    var res = await HttpData.postdata(
        LinkRestaurant.linkViewSearch, {"search": search}).then((value) {
      emit(SearchSuccessState());
      List<dynamic> data = value['data'];
      List<SearchModel> searchData =
          data.map((e) => SearchModel.fromJson(e)).toList();

      searchfood = searchData;
    }).catchError((error) {
      emit(InsertDataSearchError());
      print(error);
    });
  }

  Future refershMenu() async {
    emit(LoadingMenuDataState());
    await getMenuData().then((value) {
      menu.shuffle();
    });
  }

  var counter = 1;

  plus() {
    counter++;
    emit(plusCounter());
  }

  remove() {
    counter--;
    counter > 1 ? counter-- : counter = 1;
    emit(minusCounter());
  }

  counterClear() {
    counter = 1;
    emit(clearCounter());
  }

  var message = [];

  Future send() async {
    favs.forEach((element) {
      var index = favs.indexOf(element);
      var a = favs[index]['الطلب'];
      var b = favs[index]["الوصف"];
      var c = favs[index]["اضافات"];
      var d = favs[index]["العدد"];
      var message1 = " ${a} " " ${b} " " ${c} " " ${d} ";
      message.add(message1);

      emit(messageData());
    });
  }

  bool normDish = true;
  Color normalButtonColor = Colors.orange;
  Color doubleButtonColor = Colors.black;
  Color normalTextColor = Colors.black;
  Color doubleTextColor = Colors.white;
  bool type = true;

  doubleDish() {
    normDish = false;
    doubleButtonColor = Colors.orange;
    doubleTextColor = Colors.black;
    normalButtonColor = Colors.black;
    normalTextColor = Colors.white;
    type = false;
    emit(doubleDishState());
  }

  normalDish() {
    normDish = true;
    doubleButtonColor = Colors.black;
    doubleTextColor = Colors.white;
    normalButtonColor = Colors.orange;
    normalTextColor = Colors.black;
    type = true;
    emit(normalDishState());
  }
}
