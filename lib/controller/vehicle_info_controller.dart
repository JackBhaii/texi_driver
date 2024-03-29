import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';

class VehicleController extends GetxController {

  TextEditingController brand = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController registration = TextEditingController();
  TextEditingController millage = TextEditingController();
  TextEditingController km = TextEditingController();
  TextEditingController numberPlate = TextEditingController();
  TextEditingController passengers = TextEditingController();

  RxMap vehicleDetails ={}.obs;
  UserController userController =Get.find();



  Future<List<Map<String, dynamic>>> getVehicle() async {
    List<Map<String, dynamic>> data = [];
    QuerySnapshot list =
        await FirebaseFirestore.instance.collection("tbl_vehicle_type").get();
    for (int i = 0; i < list.docs.length; i++) {
      var map=list.docs[i].data() as Map<String, dynamic>;
      map['id']=list.docs[i].id;
      data.add(map);
    }
    return data;
  }

  Future<List<Map<String, dynamic>>> getBrand(id) async {
    List<Map<String, dynamic>> data = [];
    QuerySnapshot list =
    await FirebaseFirestore.instance.collection("tbl_brand").where("vehicle_type_id",isEqualTo: id).get();
    for (int i = 0; i < list.docs.length; i++) {
      var map=list.docs[i].data() as Map<String, dynamic>;
      map['id']=list.docs[i].id;
      data.add(map);
    }
    return data;
  }

  Future<List<Map<String, dynamic>>> getModel(id) async {
    List<Map<String, dynamic>> data = [];
    QuerySnapshot list =
    await FirebaseFirestore.instance.collection("tbl_model").where("brand_id",isEqualTo: id).get();
    for (int i = 0; i < list.docs.length; i++) {
      var map=list.docs[i].data() as Map<String, dynamic>;
      map['id']=list.docs[i].id;
      data.add(map);
    }
    return data;
  }


  showAlertCategoryDialog(BuildContext context, String value) {
    // set up the buttons
    TextEditingController textEditingController =
    TextEditingController(text: value);

    Widget continueButton = TextButton(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          decoration: BoxDecoration(
              color: primary, borderRadius: BorderRadius.circular(8)),
          child: const Text(
            "SAVE",
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          )),
      onPressed: () async {
        FirebaseFirestore.instance
            .collection("vehicleDetails")
            .doc(vehicleDetails['id'])
            .update({'vehicle_type': textEditingController.text});

        QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
            .instance
            .collection('drivers')
            .where("phone_Number", isEqualTo: userController.driversDetails['phone_Number'])
            .get();
       userController.driversDetails.value = result.docs[0].data();
        userController.driversDetails['id'] = result.docs[0].id;

        Get.back();
      },
    );
    Widget cancelButton = TextButton(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: primary)),
          child: Text(
            "CANCEL",
            style: TextStyle(
                fontSize: 12, color: primary, fontWeight: FontWeight.bold),
          )),
      onPressed: () {
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(
        child: Text(
          "Change Information",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
      ),
      backgroundColor: const Color(0xffEEE8F2),
      content: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: "Name",
            hintStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: hintTextColor,
                fontSize: 14),
            fillColor: Colors.white,
            filled: true,
            //   focusColor: Colors.white,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder()),
      ),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  
}
