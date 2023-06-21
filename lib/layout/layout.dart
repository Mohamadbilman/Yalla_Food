import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:Yalla_Food/layout/cubit/cubit.dart';
import 'package:Yalla_Food/layout/cubit/states.dart';

import 'package:Yalla_Food/shared/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconsax/iconsax.dart';

class Shop_layout extends StatelessWidget {
  const Shop_layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Yalla_Food_Cubit, Yalla_Food_States>(
        builder: (context, state) {
          Yalla_Food_Cubit cubit = Yalla_Food_Cubit.get(context);
          return SafeArea(
            child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: cubit.screen[cubit.currentIndex],
                bottomNavigationBar: CurvedNavigationBar(
                  items: [
                    Icon(
                      Iconsax.home,
                      size: navigator_icon_size,
                      color: navigationBar_Icon_Color,
                    ),
                    Icon(
                      Icons.restaurant,
                      size: navigator_icon_size,
                      color: navigationBar_Icon_Color,
                    ),
                    Icon(
                      Icons.search,
                      size: navigator_icon_size,
                      color: navigationBar_Icon_Color,
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: navigator_icon_size,
                      color: navigationBar_Icon_Color,
                    ),
                    // Icon(
                    //   Iconsax.setting,
                    //   size: navigator_icon_size,
                    //   color: navigationBar_Icon_Color,
                    // ),
                  ],
                  color: Theme.of(context).primaryColor,
                  buttonBackgroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 300),
                  onTap: (index) {
                    cubit.changeBottom(index);
                  },
                )),
          );
        },
        listener: (context, state) {});
  }
}
