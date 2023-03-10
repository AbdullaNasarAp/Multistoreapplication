import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/c_login_c.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/signup.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/auth/loginscreen.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/button_container.dart';

class CostumerLoginScreen extends StatelessWidget {
  CostumerLoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
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
                                  "Costumer Login",
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
                    child: Form(
                      key: _formKey,
                      child: Consumer<CostumerLoginProvider>(
                        builder: (context, cLp, child) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                style: const TextStyle(color: xWhite),
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
                                  cLp.email = value;
                                },
                                // controller: _emailController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: xBlue),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    labelText: 'Email',
                                    contentPadding: const EdgeInsets.all(13),
                                    labelStyle: const TextStyle(color: xWhite),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: xBlue),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: xGreen),
                                      borderRadius: BorderRadius.circular(25),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter you Password";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  cLp.password = value;
                                },
                                style: const TextStyle(color: xWhite),

                                // controller: _passwordController,
                                obscureText: cLp.passwordVisible,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: xBlue),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          cLp.passwordVisibily();
                                        },
                                        icon: Icon(
                                          cLp.passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: xWhite,
                                        )),
                                    labelText: 'Password',
                                    contentPadding: const EdgeInsets.all(13),
                                    labelStyle: const TextStyle(color: xWhite),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: xBlue),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: xGreen),
                                      borderRadius: BorderRadius.circular(25),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Forget Password ?")),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  cLp.login(context, _formKey, _scaffoldKey);
                                },
                                child: cLp.processing == true
                                    ? const CircularProgressIndicator()
                                    : const ButtonContainer(
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
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Textbutton(
                    colors: xGrey,
                    title: "Don't have an account ? ",
                    text: "Sign up",
                    ontap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CostumerSignUpScreen(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Textbutton extends StatelessWidget {
  const Textbutton({
    Key? key,
    required this.title,
    this.text,
    required this.ontap,
    required this.colors,
  }) : super(key: key);
  final String title;
  final String? text;
  final VoidCallback ontap;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: colors)),
            Text(
              text ?? '',
              style: const TextStyle(color: xBlue, fontSize: 15),
            ),
          ],
        ));
  }
}
