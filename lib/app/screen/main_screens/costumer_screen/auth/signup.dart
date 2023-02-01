// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/bottum_nav.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/auth/loginscreen.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/button_container.dart';

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
  late String profileImage;
  late String _uid;
  late String _uids;
  bool processing = false;
  XFile? _imgFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  CollectionReference customer =
      FirebaseFirestore.instance.collection('customers');

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
                            fontsz: 20),
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
                                          title: "Add your Image",
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
                      child: processing == true
                          ? const CircularProgressIndicator()
                          : InkWell(
                              onTap: () {
                                signUp();
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
                        processing == true
                            ? const CircularProgressIndicator()
                            : InkWell(
                                onTap: () async {
                                  setState(() {
                                    processing = true;
                                  });
                                  FirebaseAuth.instance
                                      .signInAnonymously()
                                      .whenComplete(() async {
                                    _uids =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    await customer.doc(_uids).set({
                                      'name': '',
                                      'email': '',
                                      'profileimage': '',
                                      'phone': '',
                                      'address': '',
                                      'cid': _uids,
                                    });
                                  });

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
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }

  signUp() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      if (_imgFile != null) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          firebasestorage.Reference ref = firebasestorage
              .FirebaseStorage.instance
              .ref('cus-images/$email.jpg');
          await ref.putFile(File(_imgFile!.path));

          _uid = FirebaseAuth.instance.currentUser!.uid;
          profileImage = await ref.getDownloadURL();
          await customer.doc(_uid).set({
            'name': name,
            'email': email,
            'profileimage': profileImage,
            'phone': '',
            'address': '',
            'cid': _uid,
          });
          _formKey.currentState!.reset();
          setState(() {
            _imgFile = null;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const CostumerLoginScreen(),
          ));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            setState(() {
              processing = false;
            });
            MyMessengerHelper.showSnackBar(
                _scaffoldKey, "The password provided is too weak");
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              processing = false;
            });
            MyMessengerHelper.showSnackBar(
                _scaffoldKey, "The account with this email already exist");
          }
        }
      } else {
        setState(() {
          processing = false;
        });
        MyMessengerHelper.showSnackBar(_scaffoldKey, "Pls Pick a Image");
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessengerHelper.showSnackBar(_scaffoldKey, "Pls fill all fields");
    }
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
