import 'package:flutter/material.dart';
import 'package:siopa/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/main_screens/supplier_screen.dart/auth/signup.dart';
import 'package:siopa/main_screens/supplier_screen.dart/sbottum_nav.dart';
import 'package:siopa/main_screens/widget/button_container.dart';
import 'package:siopa/utils/colors.dart';
import 'package:siopa/widget/button_container.dart';

class SupplierLoginScreen extends StatelessWidget {
  const SupplierLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: xBlack87,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Sopia",
                      style: TextStyle(
                        color: xWhite,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.adobe_rounded,
                      color: xBlue,
                      size: 38,
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: xBlack87,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: xGreen.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: -20,
                          left: -50,
                          child: Container(
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: xBlue.withOpacity(0.1)))),
                      Positioned(
                          left: -80,
                          top: -50,
                          child: Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: xBlack.withOpacity(0.5)))),
                      Positioned(
                        child: Container(
                            height: 250,
                            alignment: Alignment.center,
                            child: const Text(
                              "Supplier Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          contentPadding: const EdgeInsets.all(13),
                          labelStyle: const TextStyle(color: xWhite),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: xBlue),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: xGreen),
                            borderRadius: BorderRadius.circular(25),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          contentPadding: const EdgeInsets.all(13),
                          labelStyle: const TextStyle(color: xWhite),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: xBlue),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: xGreen),
                            borderRadius: BorderRadius.circular(25),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SupplierHomeScreen(),
                        ));
                      },
                      child: const ButtonContainer(
                        kWidth: 400,
                        kHeight: 50,
                        kColors: xBlue,
                        title: "Login",
                        ls: 0,
                        fontwght: FontWeight.normal,
                        fontsz: 14,
                        bRadius: 25,
                        icons: Icons.arrow_forward,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Textbutton(
                      colors: xBlue,
                      title: "Do you want to buy products  ? ",
                      ontap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const CostumerLoginScreen(),
                        ));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerButtonImage(
                            image: "images/inapp/google.png",
                            onPress: () {},
                            title: "Google"),
                        ContainerButtonImage(
                            image: "images/inapp/facebook.png",
                            onPress: () {},
                            title: "Facebook"),
                        ContainerButtonImage(
                            image: "images/inapp/guest.png",
                            onPress: () {},
                            title: "Guest"),
                      ],
                    ),
                  ],
                ),
              ),
              Textbutton(
                colors: xGrey,
                title: "Don't have an account ? ",
                text: "Sign up",
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SupplierSignUpScreen(),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
