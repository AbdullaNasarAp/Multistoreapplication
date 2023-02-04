import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/supplier_control/s_login_c.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/auth/signup.dart';
import 'package:siopa/app/screen/main_screens/widget/button_container.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/button_container.dart';

class SupplierLoginScreen extends StatelessWidget {
  SupplierLoginScreen({super.key});
  GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    child: Consumer<SupplierLoginProvider>(
                      builder: (context, sLp, child) {
                        return Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
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
                                  sLp.email = value;
                                },
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
                                  sLp.password = value;
                                },
                                obscureText: sLp.passwordVisible,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: xBlue),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          sLp.passwordVisibily();
                                        },
                                        icon: Icon(
                                          sLp.passwordVisible
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
                                  sLp.login(context, formKey, scaffoldKey);
                                },
                                child: sLp.processing == true
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
                                title: "Do you want to buy products  ? ",
                                ontap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        const CostumerLoginScreen(),
                                  ));
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                        );
                      },
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
        ),
      ),
    );
  }
}
