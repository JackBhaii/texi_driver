import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/color.dart';
import '../../constant/text.dart';
import '../../controller/binding_controller.dart';
import '../../controller/profile_controller.dart';
import '../../controller/user_controller.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  ProfileController profileController=Get.find();
  UserController userController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height*0.05,
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
              height: Get.height*0.08,
            ),
            const Center(
              child: Text("Select a photo for your profile",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize:18
              ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(profile,
            style: TextStyle(
              color: hintTextColor,
                letterSpacing: 1.2,
              fontSize: 10,
              fontWeight: FontWeight.w600
            ),
            ),
            const SizedBox(
              height: 70,
            ),
            Obx(() =>
            userController.isLoaderVisible.value ? Center(
              child: Container(
                height: 150,
                  width: 150,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200
                ),
                child: Lottie.asset("assets/json/loader_2.json",
                ),
              ),
            ) :profileController.image!=null? Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.file(File(profileController.image!.path),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),

              ),
            ): const SizedBox.shrink())
          ],
        ),
      ),

      bottomNavigationBar: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(35),
          onTap: () async {
            // userController.isLoaderVisible.value=true;
            profileController.updateImg();

          },
          child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black45,
                        offset: Offset(1,2)
                    )
                  ],
                  color: yellow,
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_forward_ios_rounded)),
        ),
        Container(
          height: 60,
          decoration: const BoxDecoration(color: Colors.white),
          child: InkWell(
            onTap: ()  async {
              int value = await profileController.pickImage();

              if(value == 1){
                setState(() {});
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: blue),
              child: const Center(
                child: Text(
                  "PLEASE SELECT",
                  style: TextStyle(
                    letterSpacing: 1,
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}
