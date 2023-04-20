// ignore_for_file: deprecated_member_use
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/address.dart';
import 'package:siopa/app/controller/costumer_control/b_nav.dart';
import 'package:siopa/app/controller/costumer_control/c_login_c.dart';
import 'package:siopa/app/controller/costumer_control/c_signup_c.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/order.dart';
import 'package:siopa/app/controller/costumer_control/payment.dart';
import 'package:siopa/app/controller/costumer_control/prod_detail.dart';
import 'package:siopa/app/controller/costumer_control/search.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/controller/stripe_id.dart';
import 'package:siopa/app/controller/supplier_control/category.dart';
import 'package:siopa/app/controller/supplier_control/edit_product.dart';
import 'package:siopa/app/controller/supplier_control/edit_store.dart';
import 'package:siopa/app/controller/supplier_control/full_screen.dart';
import 'package:siopa/app/controller/supplier_control/s_login_c.dart';
import 'package:siopa/app/controller/supplier_control/s_signup_c.dart';
import 'package:siopa/app/controller/supplier_control/upload.dart';
import 'package:siopa/app/controller/supplier_control/visitor_store.dart';
import 'package:siopa/app/screen/main_screens/welcome_screen.dart';
import 'package:siopa/app/utils/colors.dart';

void main() async {
  //stripe initializing
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  //firebase intializing
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //provider intializing in main.dart of each screen
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
        ChangeNotifierProvider(create: (context) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (context) => VisitorStore()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => EditStoreProvider()),
        ChangeNotifierProvider(
            create: (context) => CostumerHomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => EditProductProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider())
      ],
      child: MaterialApp(
        // setup theme for the application
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
