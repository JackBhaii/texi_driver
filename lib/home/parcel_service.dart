import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../constant/vars.dart';
import 'custom_drawer.dart';

class ParcelService extends StatefulWidget {
  const ParcelService({super.key});

  @override
  State<ParcelService> createState() => _ParcelServiceState();
}

class _ParcelServiceState extends State<ParcelService> {

  final GlobalKey<ScaffoldState> drawerkey2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: drawerkey2,
      drawer: const CustomDrawer(),
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            drawerkey2.currentState!.openDrawer();
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
          "Parcel Service",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "From",
                hintStyle: TextStyle(
                  color: hintTextColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 14
                ),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))
                )
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "To",
                  hintStyle: TextStyle(
                      color: hintTextColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 14
                  ),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  )
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "Select date",
                  enabled: false,
                  disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  hintStyle: TextStyle(
                      color: hintTextColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 14
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),

                  )
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text("SEARCH",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900
                ),
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}
