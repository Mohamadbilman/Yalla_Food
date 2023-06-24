import 'package:bloc/bloc.dart';
import 'package:Yalla_Food/layout/cubit/cubit.dart';
import 'package:Yalla_Food/layout/layout.dart';
import 'package:Yalla_Food/shared/bloc_observer.dart';
import 'package:Yalla_Food/shared/network/local/cache_helper.dart';
import 'package:Yalla_Food/shared/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'modules/on_boarding/cubit/cubit.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
void main() {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await CacheHelper.init();
    bool? onBoarding = CacheHelper.getData('onBoarding');
    Widget widget;
    if (onBoarding != null) {
      widget = const Shop_layout();
    } else {
      widget = const On_Boarding_Screen();
    }
    runApp(MyApp(
      widget,
    ));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  MyApp(this.startWidget);
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => Yalla_Food_Cubit()
              ..getRestauranrData()
              ..getMenuData()
              ..getCardData()),
        BlocProvider(create: (BuildContext context) => on_boardingCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: mainColor),
            accentColor: Colors.black,
            errorColor: Colors.red,
            focusColor: Colors.yellow,
            primaryColor: mainColor,
            indicatorColor: mainColor,
            shadowColor: HexColor('ffffff'),
            scaffoldBackgroundColor: HexColor('242222'),
            textTheme: TextTheme(
                labelMedium: TextStyle(
                    fontSize: mediumText,
                    color: Colors.white,
                    fontWeight: boldText),
                bodyLarge: TextStyle(
                    fontSize: mediumText,
                    color: mainColor,
                    fontWeight: boldText),
                displayLarge: TextStyle(
                    fontSize: maxText, color: titleColor, fontWeight: boldText),
                bodySmall: TextStyle(
                    fontSize: smallText, height: 1.2, color: mainColor),
                bodyMedium: TextStyle(
                    fontSize: xsmallText,
                    color: mainColor,
                    fontWeight: boldText))),
      ),
    );
  }
}
