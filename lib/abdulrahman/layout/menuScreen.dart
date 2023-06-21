import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/restaurants/dishes_details.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component.dart';
import '../class/appLink.dart';

class MenuScteen extends StatelessWidget {
  var i;
  final String? resName;

  MenuScteen({super.key, this.i, required this.resName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(resName!),
        ),
        body: BlocProvider(
          create: (context) =>
              Yalla_Food_Cubit()..getMenuresData(i!.toString()),
          child: BlocConsumer<Yalla_Food_Cubit, Yalla_Food_States>(
              builder: (context, state) {
                Yalla_Food_Cubit cubit = Yalla_Food_Cubit.get(context);
                int length = cubit.menui.length;
                return ConditionalBuilder(
                    condition: length != 0,
                    builder: (context) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: GridView.count(
                                    mainAxisSpacing: 1.0,
                                    crossAxisSpacing: 1.0,
                                    childAspectRatio: 1.65,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 1,
                                    children: List.generate(length, (index) {
                                      final product = cubit.menui[index];

                                      return buildGridProduct(context,
                                          function: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => dishe_details(
                                                id: product.foodId.toString(),
                                                image: "${product.foodImage}",
                                                price: product.foodPrice,
                                                bigPrice: product.foodBigPrice,
                                                descreption: product.foodDes,
                                                name: product.foodName),
                                          ),
                                        );
                                      },
                                          imageUrl: "${product.foodImage}",
                                          name: product.foodName,
                                          price: "${product.foodPrice} ل.س ",
                                          descreption: product.foodDes);
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
              listener: (context, state) {}),
        ));
  }
}
