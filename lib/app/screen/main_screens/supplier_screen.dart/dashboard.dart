import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/auth/loginscreen.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/balance.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/edit_profile.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/manage_product.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/my_store.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/orders.dart';
import 'package:siopa/app/screen/main_screens/supplier_screen.dart/dash_component/statics.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: xBlack87,
        appBar: AppBar(
          title: const AppBarTitle(
            title: "Dashboard",
          ),
          actions: [
            IconButton(
              onPressed: () {
                myAlert(context);
              },
              icon: const Icon(
                Icons.logout,
                color: xWhite,
              ),
            )
          ],
        ),
        body: Container(
            color: xBlack87,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: dashName.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => dashNav[index],
                        ));
                      },
                      child: Container(
                        height: 90,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: xBlack87,
                          borderRadius: BorderRadius.circular(15),
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
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: -20,
                                left: -50,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: xBlue.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -80,
                                top: -50,
                                child: Container(
                                  height: 180,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: xBlack.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                    height: 200,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            softWrap: true,
                                            dashName[index].toUpperCase(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Flexible(
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                "images/dash/dash$index.jpg",
                                                fit: BoxFit.cover,
                                                width: 180,
                                                height: 200,
                                              ),
                                              Container(
                                                width: 180,
                                                height: 200,
                                                color:
                                                    xBlack87.withOpacity(0.2),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))));
  }

  Future<dynamic> myAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: xBlack,
        title: const Text(
          "Log out",
          style: TextStyle(color: xWhite),
        ),
        content: const Text(
          "Are you sure to log out",
        ),
        actions: [
          OutlinedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "No",
              style: TextStyle(color: xWhite),
            ),
          ),
          OutlinedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(xBlue)),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => SupplierLoginScreen(),
                ),
                (route) {
                  return false;
                },
              );
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: xWhite),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> dashName = [
  "my\nstore",
  "order",
  "edit\nprofile",
  "manage\nproduct",
  "balance",
  "statics"
];
List<Widget> dashNav = [
  MyStore(),
  Order(),
  EditProfile(),
  ManaageProduct(),
  Balance(),
  Statics()
];
