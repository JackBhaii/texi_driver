import 'dart:io';

import 'package:driver/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/color.dart';
import '../constant/vars.dart';
import 'custom_drawer.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {

  final GlobalKey<ScaffoldState> drawerkey4 = GlobalKey();

  UserController userController =Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: drawerkey4,
      drawer: const CustomDrawer(),
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            drawerkey4.currentState!.openDrawer();
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
          "Documents",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Driving Lc",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ),
                          Text("Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w600
                          ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Image.network(
                        userController.driversDetails["drivingLc"]??"",
                        width: double.maxFinite,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: const Text("UPLOAD",
                            style: TextStyle(
                              color: Colors.white,
                                fontSize: 12,
                              fontWeight: FontWeight.w600
                            ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "RC Book",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ),
                          Text("Pending",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Image.network(
                        userController.driversDetails['rcBook' ]?? "",
                        width: double.maxFinite,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: const Text("UPLOAD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Insurance",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ),
                          Text("Pending",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Image.network(
                        userController.driversDetails['insurance'] ?? "",
                        width: double.maxFinite,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: const Text("UPLOAD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "PUC",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ),
                          Text("Pending",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Image.network(
                        userController.driversDetails['puc'] ?? "",
                        width: double.maxFinite,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: const Text("UPLOAD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
