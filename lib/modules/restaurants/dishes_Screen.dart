import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:Yalla_Food/layout/cubit/cubit.dart';
import 'package:Yalla_Food/modules/restaurants/dishes_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../abdulrahman/class/appLink.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component.dart';

class dishes extends StatelessWidget {
  const dishes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Yalla_Food_Cubit, Yalla_Food_States>(
        builder: (context, state) {
          Yalla_Food_Cubit cubit = Yalla_Food_Cubit.get(context);
          int length = cubit.menu.length;
          return ConditionalBuilder(
              condition: length != 0,
              builder: (context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                                final menu = cubit.menu[index];

                                return buildGridProduct(context, function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => dishe_details(
                                          id: menu.foodId.toString(),
                                          image: "${menu.foodImage}",
                                          price: menu.foodPrice,
                                          bigPrice: menu.foodBigPrice,
                                          descreption: menu.foodDes,
                                          name: menu.foodName),
                                    ),
                                  );
                                },
                                    imageUrl: "${menu.foodImage}",
                                    name: menu.foodName,
                                    price:
                                        'السعر ' ":  ${menu.foodPrice} " "ل.س",
                                    descreption: menu.foodDes);
                              }),
                            )),
                      ]),
                );
              },
              fallback: (context) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              });
        },
        listener: (context, state) {});
  }
}
