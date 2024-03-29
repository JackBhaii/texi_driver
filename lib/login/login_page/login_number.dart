import 'package:country_code_picker/country_code_picker.dart';
import 'package:driver/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/color.dart';
import '../login.dart';

class LoginNumber extends StatefulWidget {
  const LoginNumber({super.key});

  @override
  State<LoginNumber> createState() => _LoginNumberState();
}

class _LoginNumberState extends State<LoginNumber> {

  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/img/bg_img.png",
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
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
                          Get.back();
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
                      "Login Phone",
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
                SizedBox(
                  height: Get.height*0.07,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)
                  ),
                  child:  Row(
                    children: [
                      CountryCodePicker(
                        onChanged: (value) {
                          userController.countryCode=value.dialCode!;

                        },
                        initialSelection: 'IN',
                        favorite: ['+91','IN'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                      Expanded(
                        child: TextField(
                          controller: userController.phoneNumber,
                          onChanged: (value) {
                            userController.phone=value;
                          },
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: const InputDecoration(
                              counterText: "",
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                              ),
                              border: InputBorder.none
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  color: primary,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      userController.isLoaderVisible.value=true;
                      userController.getLoginOTP(context);

                    },
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Center(
                        child:  Text(
                          "CONTINUE",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Get.to(const Login());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primary)
                      ),
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical:12),
                      child:  Center(
                        child: Text("Login With Email",
                            style: TextStyle(
                                fontSize: 12,
                                color: primary,
                                fontWeight: FontWeight.w900)
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          Obx(() =>   userController.isLoaderVisible.value?Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black12,
              child: Center(child: Lottie.asset('assets/json/loader_2.json',width: 100,height: 100))):const SizedBox.shrink())
        ],
      ),
    );
  }
}
