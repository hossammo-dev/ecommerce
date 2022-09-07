import 'package:ecommerce/shared/constants.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_cubit.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_states.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:ecommerce/shared/network/remote/firebase_helper.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseHelper.initFirebase();
  await CacheHelper.initCache();
  DioHelper.initDio();

  Constants.userId = await CacheHelper.get(key: 'uid') ?? '';
  debugPrint(Constants.userId);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getProducts()
        ..getUserData(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final _lightTheme = MainCubit.get(context).lightTheme;
          return MaterialApp(
            title: 'E-Commerce Clone',
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   primarySwatch: Colors.teal,
            // ),
            theme: (_lightTheme)
                ? ThemeData.light().copyWith(primaryColorLight: Colors.teal)
                : ThemeData.dark().copyWith(
                    primaryColorDark: Colors.teal, cardColor: Colors.white),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
