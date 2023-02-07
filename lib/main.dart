// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/c_login_c.dart';
import 'package:siopa/app/controller/costumer_control/c_signup_c.dart';
import 'package:siopa/app/controller/supplier_control/s_login_c.dart';
import 'package:siopa/app/controller/supplier_control/s_signup_c.dart';
import 'package:siopa/app/controller/supplier_control/upload.dart';
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
        ChangeNotifierProvider(create: (context) => UploadProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: xBlack87,
            iconTheme: IconThemeData(color: xWhite),
            titleTextStyle: TextStyle(fontFamily: "Poppins", color: xWhite),
            actionsIconTheme: IconThemeData(color: xWhite),
          ),
          tabBarTheme:
              const TabBarTheme(labelStyle: TextStyle(fontFamily: "Poppins")),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: xBlack87,
          ),
          iconTheme: const IconThemeData(color: xWhite),
          textTheme: const TextTheme(
            headline1: TextStyle(fontFamily: "Poppins", color: xWhite),
            headline2: TextStyle(fontFamily: "Poppins", color: xWhite),
            headline3: TextStyle(fontFamily: "Poppins", color: xWhite),
            bodyText1: TextStyle(fontFamily: "Poppins", color: xWhite),
            bodyText2: TextStyle(fontFamily: "Poppins", color: xWhite),
            subtitle1: TextStyle(fontFamily: "Poppins", color: xWhite),
            subtitle2: TextStyle(fontFamily: "Poppins", color: xWhite),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
      ),
    );
  }
}
