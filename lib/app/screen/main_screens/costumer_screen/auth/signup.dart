// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/c_signup_c.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/bottum_nav.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/auth/loginscreen.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/button_container.dart';

class CostumerSignUpScreen extends StatelessWidget {
  CostumerSignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ScaffoldMessenger(
        key: scaffoldKey,
        child: Scaffold(
          backgroundColor: xBlack87,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Consumer<CostumerSignupProvider>(
                  builder: (context, cSp, child) {
                    return Column(
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 200,
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: xBlack87,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: xBlue.withOpacity(0.3),
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
                                        "Costumer Signup",
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
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: xWhite),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter you Fullname";
                            }
                            return null;
                          },
                          //  controller: _nameController,
                          onChanged: (value) {
                            cSp.name = value;
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              labelStyle: const TextStyle(color: xWhite),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xGreen),
                                borderRadius: BorderRadius.circular(25),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: xWhite),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter you Email";
                            } else if (value.isEmailValidate() == false) {
                              return "Invalid Email";
                            } else if (value.isEmailValidate() == true) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cSp.email = value;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
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
                        TextFormField(
                          style: TextStyle(color: xWhite),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter you Password";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cSp.password = value;
                          },
                          // controller: _passwordController,
                          obscureText: cSp.passwordVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cSp.passwordVisibily();
                                  },
                                  icon: Icon(
                                    cSp.passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: xWhite,
                                  )),
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
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: xWhite),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter you Password";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cSp.password = value;
                          },
                          obscureText: cSp.passwordVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 2, color: xBlue),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cSp.passwordVisibily();
                                  },
                                  icon: Icon(
                                    cSp.passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: xWhite,
                                  )),
                              labelText: 'Confirm Password',
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
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const CostumerHomeScreen(),
                            ));
                          },
                          child: cSp.processing == true
                              ? const CircularProgressIndicator()
                              : InkWell(
                                  onTap: () {
                                    cSp.signUp(context, formKey, scaffoldKey);
                                  },
                                  child: const ButtonContainer(
                                    kWidth: 400,
                                    kHeight: 50,
                                    kColors: xBlue,
                                    title: "Sign Up",
                                    ls: 0,
                                    fontwght: FontWeight.normal,
                                    fontsz: 14,
                                    bRadius: 25,
                                    icons: Icons.arrow_forward,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Textbutton(
                          colors: xBlue,
                          title: "Do you want to sell products  ? ",
                          ontap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => SupplierLoginScreen(),
                            ));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                FirebaseAuth.instance.signInAnonymously();
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: xBlack,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "images/inapp/google.png",
                                        filterQuality: FilterQuality.high,
                                        cacheHeight: 40,
                                        cacheWidth: 40,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Google",
                                      style: TextStyle(color: xGrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: xBlack,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "images/inapp/facebook.png",
                                        filterQuality: FilterQuality.high,
                                        cacheHeight: 40,
                                        cacheWidth: 40,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Facebook",
                                      style: TextStyle(color: xGrey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            cSp.processings == true
                                ? const CircularProgressIndicator()
                                : InkWell(
                                    onTap: () async {
                                      cSp.processings = true;
                                      cSp.anonymousAuth();

                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            const CostumerHomeScreen(),
                                      ));
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: xBlack,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "images/inapp/guest.png",
                                              filterQuality: FilterQuality.high,
                                              cacheHeight: 40,
                                              cacheWidth: 40,
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Guest",
                                            style: TextStyle(color: xGrey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
