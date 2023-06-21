import 'package:Yalla_Food/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:Yalla_Food/layout/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component.dart';
import '../../shared/style/style.dart';
import '../restaurants/dishes_details.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({Key? key}) : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Yalla_Food_Cubit, Yalla_Food_States>(
        builder: (context, state) {
          Yalla_Food_Cubit cubit = Yalla_Food_Cubit.get(context);
          Key key = new GlobalKey();
          // int length = cubit.favs.length ;

          int length = cubit.favs.length;
          return Scaffold(
            floatingActionButton: cubit.favs.isNotEmpty
                ? CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                        onPressed: () {
                          cubit.send().then((value) {
                            cubit.favs.forEach((element) {
                              var index = cubit.favs.indexOf(element);
                              var a = cubit.favs[index]['الطلب'];
                              var b = cubit.favs[index]["الوصف"];
                              var c = cubit.favs[index]["اضافات"];
                              var d = cubit.favs[index]["العدد"];
                              var message = " ${a} "
                                  " ${b} "
                                  " ${c} "
                                  " ${d} ";

                              cubit.sendWhatsAppMessage(
                                  number: '+963936007954', message: message);
                            });
                          });
                        },
                        icon: const Icon(
                          Iconsax.truck_fast,
                          color: Colors.white,
                        )),
                  )
                : Text(""),
            body: ConditionalBuilder(
                condition: cubit.favs.isNotEmpty,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsetsDirectional.all(20.0),
                              alignment: Alignment.bottomRight,
                              width: double.infinity,
                              child: Text(" : طلباتك",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge)),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: GridView.count(
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 1.0,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio *
                                        10,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 1,
                                children: List.generate(length, (index) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    trailing: TextButton(
                                        onPressed: () {
                                          cubit.deleteFav(index: index);
                                        },
                                        child: Text(
                                          'إلغاء',
                                          style: TextStyle(color: Colors.red),
                                          textDirection: TextDirection.rtl,
                                        )),
                                    leading: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: shimmerImage(
                                            imageUrl: cubit.favimage[index])),
                                    title: Text(
                                      cubit.favTitle[index],
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                      textDirection: TextDirection.rtl,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          maxLines: 3,
                                          cubit.favAddition[index],
                                          style: TextStyle(color: Colors.white),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              cubit.favType[index].toString() ==
                                                      "true"
                                                  ? "عادي"
                                                  : "دبل",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Text(
                                              "العدد :"
                                              "${cubit.count[index].toString()}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Text(
                                              "السعر :"
                                              "${cubit.favprice[index].toString()}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              )),
                        ]),
                  );
                },
                fallback: (context) {
                  return Center(
                    child: Text('لا يوجد اي محفوظات'),
                  );
                }),
          );
        },
        listener: (context, state) {});
  }
}
