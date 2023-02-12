// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/c_login_c.dart';
import 'package:siopa/app/controller/costumer_control/c_signup_c.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/payment.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/controller/supplier_control/category.dart';
import 'package:siopa/app/controller/supplier_control/full_screen.dart';
import 'package:siopa/app/controller/supplier_control/s_login_c.dart';
import 'package:siopa/app/controller/supplier_control/s_signup_c.dart';
import 'package:siopa/app/controller/supplier_control/upload.dart';
import 'package:siopa/app/controller/supplier_control/visitor_store.dart';
import 'package:siopa/app/screen/main_screens/welcome_screen.dart';
import 'package:siopa/app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SupplierLoginProvider()),
        ChangeNotifierProvider(create: (context) => SupplierSignupProvider()),
        ChangeNotifierProvider(create: (context) => CostumerSignupProvider()),
        ChangeNotifierProvider(create: (context) => CostumerLoginProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => UploadProvider()),
        ChangeNotifierProvider(create: (context) => FullScreenProvider()),
        ChangeNotifierProvider(create: (context) => VisitorStore()),
        ChangeNotifierProvider(create: (context) => VisitorStore()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: xBlue,
            iconTheme: IconThemeData(color: xWhite),
            titleTextStyle: TextStyle(fontFamily: "Poppins", color: xWhite),
            actionsIconTheme: IconThemeData(color: xWhite),
          ),
          tabBarTheme:
              const TabBarTheme(labelStyle: TextStyle(fontFamily: "Poppins")),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: xBlue,
          ),
          iconTheme: const IconThemeData(color: xWhite),
          scaffoldBackgroundColor: xWhite,
          textTheme: const TextTheme(
            headline1: TextStyle(fontFamily: "Poppins", color: xBlack87),
            headline2: TextStyle(fontFamily: "Poppins", color: xBlack87),
            headline3: TextStyle(fontFamily: "Poppins", color: xBlack87),
            bodyText1: TextStyle(fontFamily: "Poppins", color: xBlack87),
            bodyText2: TextStyle(fontFamily: "Poppins", color: xBlack87),
            subtitle1: TextStyle(fontFamily: "Poppins", color: xBlack87),
            subtitle2: TextStyle(fontFamily: "Poppins", color: xBlack87),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
      ),
    );
  }
}
