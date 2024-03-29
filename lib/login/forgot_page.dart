import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import 'login.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/img/bg_img.png",
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Card(
                  elevation: 8,
                  shape: const CircleBorder(),
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                         Get.off(const Login());
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios_new),
                        )),
                  ),
                ),
                SizedBox(
                  height: Get.height*0.20,
                ),
                const Center(
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          letterSpacing: 1.2,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    )),
                Center(
                  child: Container(
                      height: 3,
                      width: 90,
                      margin: const EdgeInsets.only(top: 8),
                      color: primary),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Enter the email address we will send an OPT to create new password.",
                  style: TextStyle(
                      color: Color(0xff666666),
                      letterSpacing: 1,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  color: Colors.white,
                  child: const TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        hintText: "Email",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  color: primary,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {},
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Center(
                        child: Text(
                          "SEND",
                          style: TextStyle(
                            fontSize: 12,
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
