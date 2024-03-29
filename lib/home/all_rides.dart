import 'package:driver/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import '../constant/vars.dart';
import 'custom_drawer.dart';

class AllRides extends StatefulWidget {
  const AllRides({super.key});

  @override
  State<AllRides> createState() => _AllRidesState();
}

class _AllRidesState extends State<AllRides> {
  final GlobalKey<ScaffoldState> drawerkey1 = GlobalKey();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerkey1,
      drawer: const CustomDrawer(),
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            drawerkey1.currentState!.openDrawer();
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
          "All Rides",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 14),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/img/empty_placeholde..png",
            width: double.maxFinite,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          const Text(
            "Your don't have any ride booked.",
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primary,
        child: const Icon(Icons.add_location,color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomSheet: const Padding(padding: EdgeInsets.only(bottom: 50  )),
    );
  }
}
