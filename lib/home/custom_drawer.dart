import 'package:driver/controller/binding_controller.dart';
import 'package:driver/home/parcel_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constant/color.dart';
import '../constant/vars.dart';
import '../controller/user_controller.dart';
import '../login/login.dart';
import 'all_parcel.dart';
import 'all_rides.dart';
import 'document.dart';
import 'my_profile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 180,
            child: DrawerHeader(
              decoration: BoxDecoration(color: primary),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Obx(() => Image.network(
                          userController.driversDetails['profile'] ?? "",
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Row(
                    children: [
                      Text(
                        userController.driversDetails['first_name'] ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        userController.driversDetails['last_name'] ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          userController.driversDetails['email'] ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Obx(() =>Switch(value: userController.isOnline.value, onChanged: (value) {
                        userController.isOnline.value = value;
                      },))
                    ],
                  ),
                ],
              ),
            ),
          ),
          drawerList(
            index: 0,
            onTap: () {
              if (selectedDrawerIndex == 0) {
                Navigator.pop(context);
              } else {
                selectedDrawerIndex = 0;
                Get.to(const AllRides());
              }
            },
            icons: Icons.directions_car_filled,
            title: "All Rides",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 1;
              Get.to(const ParcelService());
              setState(() {});
            },
            index: 1,
            icons: Icons.local_shipping_outlined,
            title: "Parcel Service",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 2;
              Get.to(const AllParcel());
              setState(() {});
            },
            index: 2,
            icons: Icons.local_shipping_outlined,
            title: "All Parcel",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 3;
              Get.to(const Documents(),binding: BindingController());
              setState(() {});
            },
            index: 3,
            icons: Icons.inventory_outlined,
            title: "Document",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 4;
              Get.to(const MyProfile(),binding: BindingController());
              setState(() {});
            },
            index: 4,
            icons: Icons.person_2_outlined,
            title: "My Profile",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 5;
              setState(() {});
            },
            index: 5,
            icons: Icons.settings_suggest_outlined,
            title: "Car Service History",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 6;
              setState(() {});
            },
            index: 6,
            icons: Icons.account_balance_wallet_outlined,
            title: "My Earning",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 7;
              setState(() {});
            },
            index: 7,
            icons: Icons.account_balance,
            title: "Add Bank",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 8;
              setState(() {});
            },
            index: 8,
            icons: Icons.language,
            title: "Change Language",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 9;
              setState(() {});
            },
            index: 9,
            icons: Icons.support_agent_outlined,
            title: "Contact Us",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 10;
              setState(() {});
            },
            index: 10,
            icons: Icons.design_services,
            title: "Terms of Service",
          ),
          drawerList(
            onTap: () {
              selectedDrawerIndex = 11;
              setState(() {});
            },
            index: 11,
            icons: Icons.error,
            title: "Privacy Policy",
          ),
          drawerList(
            onTap: () {
              GetStorage().write("isLogin", false);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) =>  const Login()), (Route route) => false);

              selectedDrawerIndex = 12;
            },
            index: 14,
            icons: Icons.logout_outlined,
            title: "Sign Out",
          ),
        ],
      ),
    );
  }

  Widget drawerList(
      {required dynamic icons,
      required String title,
      Function? onTap,
      int? index,
      bool isImage = false}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: ListTile(
        title: Row(
          children: [
            isImage
                ? Image.asset(
                    icons,
                    width: 20,
                    height: 20,
                  )
                : Icon(
                    icons as IconData?,
                    size: 30,
                    color: index == selectedDrawerIndex
                        ? const Color(0xff654EA8)
                        : Colors.black,
                  ),
            const SizedBox(width: 25),
            Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: index == selectedDrawerIndex
                      ? const Color(0xff654EA8)
                      : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
