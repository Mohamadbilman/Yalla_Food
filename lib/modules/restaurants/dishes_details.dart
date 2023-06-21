import 'package:Yalla_Food/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/style/style.dart';

class dishe_details extends StatelessWidget {
  final String image;
  final dynamic descreption;
  final dynamic name;
  final dynamic price;
  final dynamic bigPrice;
  final dynamic id;

  dishe_details({
    Key? key,
    required this.image,
    required this.price,
    required this.bigPrice,
    required this.descreption,
    required this.name,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Yalla_Food_Cubit cubit = Yalla_Food_Cubit.get(context);
    return BlocConsumer<Yalla_Food_Cubit, Yalla_Food_States>(
        builder: (context, state) {
          // var number1 = num.parse(price).toString() == '0' ? 'لا يوجد' : num.parse(price) * cubit.counter;
          var bigNumber = num.parse(bigPrice).toString() == '0'
              ? "لا يوجد دبل من الطبق المطلوب"
              : num.parse(bigPrice) * cubit.counter;
          MediaQueryData query = MediaQuery.of(context);
          final textScale = query.textScaleFactor;
          var number =
              cubit.normDish ? num.parse(price) * cubit.counter : bigNumber;

          TextEditingController additionController = TextEditingController();
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '$name',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 23.0 * textScale),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: query.size.height,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: carouselPadding,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).shadowColor,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    blurStyle: BlurStyle.normal,
                                    offset: Offset.fromDirection(50))
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: shimmerImage(imageUrl: image)),
                      SizedBox(height: 20.0),
                      detailsText(
                          text: name,
                          style: Theme.of(context).textTheme.displayLarge),
                      SizedBox(height: 20),
                      detailsText(
                          text: descreption,
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          detailsText(
                              text: number.toString(),
                              style: Theme.of(context).textTheme.labelMedium),
                          detailsText(
                              text: ' السعر' ' : ',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: query.size.aspectRatio * 20),
                          width: query.size.width / 4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    cubit.plus();
                                  },
                                  icon: Icon(Icons.add_circle_outlined,
                                      color: Colors.white)),
                              Text(
                                cubit.counter.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0 * textScale),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.remove();
                                  },
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.white,
                                  ))
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: query.size.aspectRatio * 20),
                          width: query.size.width / 4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: cubit.doubleButtonColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () {
                                    cubit.doubleDish();
                                  },
                                  child: Text(
                                    "دبل",
                                    style: TextStyle(
                                        color: cubit.doubleTextColor,
                                        fontSize: 15.0 * textScale,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: cubit.normalButtonColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                  onPressed: () {
                                    cubit.normalDish();
                                  },
                                  child: Text(
                                    "عادي",
                                    style: TextStyle(
                                        color: cubit.normalTextColor,
                                        fontSize: 15.0 * textScale,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      defaultFormField(context, onSubmit: (value) {
                        cubit
                            .addFav(
                                price: bigNumber.toString(),
                                type: cubit.type,
                                number: number.toString() ==
                                        "لا يوجد دبل من الطبق المطلوب"
                                    ? "0"
                                    : cubit.counter.toString(),
                                value: name,
                                image: image,
                                desc: descreption,
                                add: additionController.text == ""
                                    ? 'لا يوجد اضافات'
                                    : additionController.text)
                            .then((value) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            showCloseIcon: true,
                            closeIconColor: Colors.white,
                            content: Text(
                              "تم الاضافة",
                              textDirection: TextDirection.rtl,
                            ),
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.black,
                            key: Key('fookey'),
                          ));
                          cubit.counterClear();
                        });
                      },
                          controller: additionController,
                          text: 'قم بكتابة اي اضافات',
                          hintText: "قم بكتابة اي اضافات",
                          validator: (value) {}),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(context,
                          width: double.infinity,
                          textColor: Colors.black,
                          color: Colors.orange, function: () {
                        cubit
                            .addFav(
                                price: number.toString() ==
                                        "لا يوجد دبل من الطبق المطلوب"
                                    ? "0"
                                    : number.toString(),
                                type: cubit.type,
                                number: number.toString() ==
                                        "لا يوجد دبل من الطبق المطلوب"
                                    ? "0"
                                    : cubit.counter.toString(),
                                value: name,
                                image: image,
                                desc: descreption,
                                add: additionController.text == ""
                                    ? 'لا يوجد اضافات'
                                    : additionController.text)
                            .then((value) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            showCloseIcon: true,
                            closeIconColor: Colors.white,
                            content: Text(
                              "تم الاضافة",
                              textDirection: TextDirection.rtl,
                            ),
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.black,
                            key: Key('fookey'),
                          ));
                          cubit.counterClear();
                        });
                      }, text: 'إضافة إلى السلة')
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
