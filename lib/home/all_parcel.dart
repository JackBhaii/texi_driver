import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/vars.dart';
import 'custom_drawer.dart';

class AllParcel extends StatefulWidget {
  const AllParcel({super.key});

  @override
  State<AllParcel> createState() => _AllParcelState();
}

class _AllParcelState extends State<AllParcel> {

  final GlobalKey<ScaffoldState> drawerkey3 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: drawerkey3,
      drawer: const CustomDrawer(),
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            drawerkey3.currentState!.openDrawer();
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
          "All Parcel",
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
            "Your don't have any parcel confirmed.",
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
