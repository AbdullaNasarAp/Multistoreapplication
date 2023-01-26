import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siopa/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/main_screens/costumer_screen/bottum_nav.dart';
import 'package:siopa/main_screens/supplier_screen.dart/auth/loginscreen.dart';
import 'package:siopa/main_screens/widget/button_container.dart';
import 'package:siopa/utils/colors.dart';
import 'package:siopa/widget/button_container.dart';

// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();

class CostumerSignUpScreen extends StatefulWidget {
  const CostumerSignUpScreen({super.key});

  @override
  State<CostumerSignUpScreen> createState() => _CostumerSignUpScreenState();
}

class _CostumerSignUpScreenState extends State<CostumerSignUpScreen> {
  bool passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late String name;
  late String email;
  late String password;
  XFile? _imgFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

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
          body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const TextTitle(
                            title: "Costumer Sign Up",
                            ls: 0,
                            fontwght: FontWeight.bold,
                            fontsz: 24),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: xBlack87,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: xBlue, width: 1)),
                            height: 150,
                            width: 150,
                            child: _imgFile == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.add_a_photo,
                                        size: 20,
                                        color: xWhite,
                                      ),
                                      TextTitle(
                                          title: "Add you Image",
                                          ls: 0,
                                          fontwght: FontWeight.normal,
                                          fontsz: 10)
                                    ],
                                  )
                                : Image(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(_imgFile!.path)))),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  pickImageFromCamera();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: xBlack87,
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: xBlue, width: 1)),
                                  height: 45,
                                  width: 45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.camera_alt),
                                      TextTitle(
                                          title: "Camera",
                                          ls: 0,
                                          fontwght: FontWeight.normal,
                                          fontsz: 8)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  pickImageFromGallery();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: xBlack87,
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: xBlue, width: 1)),
                                  height: 45,
                                  width: 45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.album),
                                      TextTitle(
                                          title: "Gallery",
                                          ls: 0,
                                          fontwght: FontWeight.normal,
                                          fontsz: 8)
                                    ],
                                  ),
                                ),
                              ),
                            ])
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter you Fullname";
                        }
                        return null;
                      },
                      //  controller: _nameController,
                      onChanged: (value) {
                        name = value;
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
                        email = value;
                      },
                      // controller: _emailController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter you Password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      // controller: _passwordController,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: xBlue),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: Icon(
                                passwordVisible
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
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const CostumerHomeScreen(),
                        ));
                      },
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_imgFile != null) {
                              log("Img selected");
                            } else {
                              MyMessengerHelper.showSnackBar(
                                  _scaffoldKey, "Pls Pick a Image");
                            }
                            log("valid");

                            log(name);
                            log(email);
                            log(password);
                            _formKey.currentState!.reset();
                            setState(() {
                              _imgFile = null;
                            });
                          } else {
                            MyMessengerHelper.showSnackBar(
                                _scaffoldKey, "Pls fill all fields");
                            log("Not valid");
                          }
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SupplierLoginScreen(),
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
            )),
          ),
        ),
      ),
    );
  }

  void pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );
      setState(() {
        _imgFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      log(_pickImageError);
    }
  }

  void pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );
      setState(() {
        _imgFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
      log(_pickImageError);
    }
  }
}
