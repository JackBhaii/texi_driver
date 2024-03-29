
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../constant/color.dart';
import '../../controller/user_controller.dart';

class SignUpOtp extends StatefulWidget {

  const SignUpOtp({super.key});

  @override
  State<SignUpOtp> createState() => _SignUpOtpState();
}

class _SignUpOtpState extends State<SignUpOtp> {


  UserController userController= Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/img/bg_img.png",
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
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
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  const Center(
                      child: Text(
                    "Enter OTP",
                    style: TextStyle(
                        letterSpacing: 1.2,
                        fontSize: 22,
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
                    height: 70,
                  ),
                  Pinput(
                    onCompleted: (value) {
                     userController.otp = value;
                    },
                    length: 6,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    autofocus: true,
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
                        // debugPrint(widget.verificationId);
                        userController.isLoaderVisible.value=true;
                        userController.verifySingUpOTP();
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Center(
                          child: Text(
                            "DONE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
           Obx(() => userController.isLoaderVisible.value? Container(
             width: Get.width,
             height: Get.height,
             color: Colors.black12,
             child: Center(
                 child: Lottie.asset('assets/json/loader_2.json',width: 100,height: 100)),
           ) : const SizedBox.shrink())
        ],
      ),
    );
  }
}
