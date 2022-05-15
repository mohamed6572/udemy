import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_tracker/layout/Shop_App/cubit/cubit.dart';
import 'package:gps_tracker/layout/Shop_App/shop_layout.dart';
import 'package:gps_tracker/layout/Social_app/cubit/cubit.dart';
import 'package:gps_tracker/layout/Social_app/social_layout.dart';
import 'package:gps_tracker/modules/Shop_App/Login/shop_login_screan.dart';
import 'package:gps_tracker/modules/Social_app/social_login/social_login_screan.dart';

import 'package:gps_tracker/shared/Bloc_Observer.dart';
import 'package:gps_tracker/shared/Cubit/cubit.dart';
import 'package:gps_tracker/shared/Cubit/states.dart';
import 'package:gps_tracker/shared/components/constens.dart';
import 'package:gps_tracker/shared/network/local/casheHelper.dart';
import 'package:gps_tracker/shared/network/remote/dio_helper.dart';
import 'package:gps_tracker/shared/styles/themes.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/News_Layout/Cubit/cubit.dart';
import 'layout/News_Layout/Cubit/states.dart';
import 'layout/News_Layout/News_Layout.dart';
import 'modules/Shop_App/onBoarding/onBoarding.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      Dio_Helper.init();
      await casheHelper.Init();
      bool? isDark = casheHelper.getData(key: "isDark");
      // bool? onboarding = casheHelper.getData(key: "onBoarding");
      // token = casheHelper.getData(key: "token");
      uId = casheHelper.getData(key: "uId");
      Widget? widget;
      // if (onboarding != null) {
      //   if (token != null)
      //     widget = Shop_Layout();
      //   else
      //     widget = ShopLoginScrean();
      // } else {
      //   widget = onBoarding();
      // }
      if (uId != null) {
        widget = SocialLayout();
      } else {
        widget = SocialLoginScrean();
      }

      runApp(MyApp(isDark: isDark, StartWidget: widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  //
  bool? isDark = false;
  Widget? StartWidget;

  MyApp({required this.isDark, required this.StartWidget});

  @override
  Widget build(BuildContext context) {
    //  return MaterialApp(
    //    debugShowCheckedModeBanner: false,
    //    theme: lightTheme,
    //    darkTheme:darkTheme,
    //    themeMode: ThemeMode.light,
    //  //  cubit.isDark ? ThemeMode.dark : ThemeMode.light,
    //
    //    home: onBoarding(),
    //  );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
            create: (context) =>
                AppCubit()..ChangeAppMode(fromSared: isDark ?? false)),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getcateogriesData()
              ..getFavorites()
              ..getProfile()),
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()..getPosts())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
                  //ThemeMode.light,
                  cubit.isDark ? ThemeMode.dark : ThemeMode.light,
              home: StartWidget
          )
          ;
        },
      ),
    );
  }
}
