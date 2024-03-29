
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/controller/profile_controller.dart';
import 'package:driver/controller/user_controller.dart';
import 'package:driver/home/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constant/color.dart';
import '../controller/vehicle_info_controller.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  UserController userController = Get.find();
  ProfileController profileController = Get.find();
  VehicleController vehicleController =Get.find();


  final GlobalKey<ScaffoldState> drawerkey5 = GlobalKey();

  bool isLoaderVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerkey5,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            // debugPrint("Le Nach Le Nach");
            drawerkey5.currentState!.openDrawer();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Image.asset(
              "assets/img/menu.png",
              height: 10,
              width: 10,
              // alignment: Alignment.topCenter,
            ),
          ),
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              child: Stack(
                // alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: primary,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(() =>
                        userController.isLoaderVisible.value ? Container(
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Lottie.asset("assets/json/loader_2.json",
                              // height:0,width: 00
                          ),
                        ):
                          profileController.profilePath.value == ''
                              ? Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      userController.driversDetails['profile'] ?? "",

                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Obx(() => Image.network(
                                          profileController.profilePath.value,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () async {
                                // isLoaderVisible=true;
                              int value = await profileController.pickImage(isUpdate: true);

                                if(value == 1){
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    "assets/img/edit_icon.png",
                                    height: 20,
                                    width: 20,
                                  ))),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Personal Information",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () async {
                  userController.showAlertNameDialog(context,userController.driversDetails['first_name'] ?? "");

                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_2_outlined,
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "First Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Obx(() => Text(
                            userController.driversDetails['first_name'] ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ),)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/img/edit_icon.png",
                        height: 20,
                        width: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  userController.showAlertLastNameDialog(context, userController.driversDetails['last_name'] ?? "");
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_2_outlined,
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Last Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Obx(() => Text(
                            userController.driversDetails['last_name'] ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/img/edit_icon.png",
                        height: 20,
                        width: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.phone_outlined,
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Phone",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        Text(
                          userController.driversDetails['phone_Number'] ?? "",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.email_outlined,
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        Text(
                          userController.driversDetails['email'] ?? "",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  userController.showAlertPasswordDialog(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/img/edit_icon.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Vehicle Information",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  vehicleController.showAlertCategoryDialog(context, vehicleController.vehicleDetails["vehicle_type"] ?? "");
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/img/category.png",
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 15),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Category",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Text(vehicleController.vehicleDetails["vehicle_type"] ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/img/edit_icon.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/img/category.png",
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 15),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Brand",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Text(vehicleController.vehicleDetails["brand_type"] ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                // color: Colors.red,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/img/edit_icon.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/img/category.png",
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 15),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Model",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Text(vehicleController.vehicleDetails["model_type"] ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                // color: Colors.red,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/img/edit_icon.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.palette_outlined,
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Color",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Text(vehicleController.vehicleDetails["color_type"] ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                // color: Colors.red,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/img/edit_icon.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      "assets/img/category.png",
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 15),
                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Car Registration",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Text(vehicleController.vehicleDetails["registration_year"] ?? "",
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                // color: Colors.red,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/img/edit_icon.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete,
                      size: 30,
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delete",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                          Text(
                            "Delete Account",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/img/edit_icon.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

}
