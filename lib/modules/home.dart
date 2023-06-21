import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../abdulrahman/class/appLink.dart';
import '../abdulrahman/layout/menuScreen.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/component.dart';
import '../shared/style/style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class home_screen extends StatefulWidget {
  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<Yalla_Food_Cubit, Yalla_Food_States>(
        builder: (context, state) {
      Yalla_Food_Cubit cubit = Yalla_Food_Cubit.get(context);
      int length = cubit.restaurant.length;

      return Scaffold(
          key: scaffoldKey,
          floatingActionButton: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
                onPressed: () {
                  cubit.restaurant.clear();
                  cubit.getRestauranrData();
                },
                icon: const Icon(
                  Iconsax.refresh,
                  color: Colors.white,
                )),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: ConditionalBuilder(
              condition: length != 0,
              builder: (context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CarouselSlider(
                            items: List.generate(
                                length,
                                (index) => Container(
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: carouselPadding,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Theme.of(context).shadowColor,
                                              blurRadius: 5,
                                              spreadRadius: 2,
                                              blurStyle: BlurStyle.normal,
                                              offset: Offset.fromDirection(50))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: shimmerImage(
                                        imageUrl:
                                            "${cubit.restaurant[index].resImage}"))),
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              height: MediaQuery.of(context).size.height / 3.5,
                              initialPage: 1,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 1),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                            )),
                        Container(
                            padding: const EdgeInsetsDirectional.all(20.0),
                            alignment: Alignment.bottomRight,
                            width: double.infinity,
                            child: Text(':' " المطاعم المتوفرة",
                                style:
                                    Theme.of(context).textTheme.displayLarge)),
                        Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: GridView.count(
                              mainAxisSpacing: 1.0,
                              crossAxisSpacing: 1.0,
                              childAspectRatio: 1.65,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 1,
                              children: List.generate(length, (index) {
                                final restaurant = cubit.restaurant[index];
                                var price;
                                restaurant.resPrice == '0'
                                    ? price = 'لا يوجد توصيل'
                                    : price = "${restaurant.resPrice}  ل.س ";
                                return buildGridProduct(context, function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MenuScteen(
                                        i: restaurant.resId,
                                        resName: restaurant.resName,
                                      ),
                                    ),
                                  );
                                },
                                    imageUrl: restaurant.resImage,
                                    name: restaurant.resName,
                                    price: 'سعر التوصيل'
                                        " : ${price}",
                                    descreption: restaurant.resDes);
                              }),
                            )),
                      ]),
                );
              },
              fallback: (context) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).indicatorColor,
                  ),
                );
              }));
    }, listener: (context, state) {
      state is! shopErrorHomeDataState || state is! shopErrorHomeDataState;
    });
  }
}
