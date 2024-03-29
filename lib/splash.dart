import 'package:driver/controller/user_controller.dart';
import 'package:driver/home/all_rides.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constant/vars.dart';
import 'login/login.dart';
import 'onboard.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  UserController userController = Get.find();
  final strong = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2),
      () {
          if(strong.read("isFirstTime")??true)
            {
              Get.off(const OnBoard());
            }
          else {
            if(strong.read("isLogin")??false)
            {
              userController.driversDetails.value = strong.read("driversDetails")??{};
              debugPrint("");
              Get.off(const AllRides());
            }else {
              Get.off(const Login());
            }

          }

      },


    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/img/splash_screen.png",
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover),
      ),
    );
  }
}
