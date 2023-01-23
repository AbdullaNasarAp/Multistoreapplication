import 'package:flutter/material.dart';
import 'package:siopa/main_screens/costumer_screen/loginscreen.dart';
import 'package:siopa/utils/colors.dart';
import 'package:siopa/widget/button_container.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 173, 54, 54),
            image: DecorationImage(
                image: AssetImage('images/inapp/back.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter?.mode(
                    Color.fromARGB(0, 78, 55, 179), BlendMode.darken))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 2,
            ),
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
            Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(15),
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/inapp/containerImage.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter?.mode(
                              Color.fromARGB(255, 138, 5, 5),
                              BlendMode.saturation)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Modern Basics.\nRadical \nTransparency.",
                style: TextStyle(
                  color: xWhite,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const CostumerLoginScreen(),
                      ));
                    },
                    child: const ButtonContainer(
                        icons: Icons.arrow_forward,
                        kWidth: 350,
                        kHeight: 42,
                        kColors: xBlue,
                        title: "Next",
                        ls: 0,
                        fontwght: FontWeight.normal,
                        fontsz: 16,
                        bRadius: 50),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
