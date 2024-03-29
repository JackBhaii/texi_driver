

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/controller/user_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../login/sign_up_page/document_page.dart';
import 'binding_controller.dart';


class ProfileController extends GetxController{

  UserController userController=Get.find();

  final ImagePicker picker = ImagePicker();
  XFile?  image;
  RxString profilePath = ''.obs;
  final strong = GetStorage();

  final GlobalKey<ScaffoldState> drawerkey5 = GlobalKey();

Future<int> pickImage ({bool isUpdate = false}) async {
  userController.isLoaderVisible.value=true;
  image = await picker.pickImage(source: ImageSource.gallery);
  final storageRef = FirebaseStorage.instance.ref();
  String  currentTime=DateTime.now().toString();
  final mountainsRef = storageRef.child("$currentTime.jpg");
  File file = File(image!.path);
  await mountainsRef.putFile(file);
  profilePath.value =await mountainsRef.getDownloadURL();
  if(isUpdate){
    FirebaseFirestore.instance.collection("drivers").doc(userController.driversDetails['id']).update(
        {"profile" : profilePath.value});
    userController.driversDetails['profile'] = profilePath.value;
    strong.write("driversDetails",userController.driversDetails.value);
  }

  if(image != null){
    userController.isLoaderVisible.value=false;
    return 1;

  }else{
    userController.isLoaderVisible.value=false;
    return 0;
  }
}

void updateImg() {

  if (image == null) {
    Fluttertoast.showToast(
        msg:"Please Choose Image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    userController.driversDetails['profile']=profilePath.value;
    GetStorage().write("isLogin", true);
    GetStorage().write("userDetails",userController.driversDetails);

    FirebaseFirestore.instance.collection('drivers').doc(userController.driversDetails['id']).update({
      'profile': profilePath.value,
    });

    Get.to(const Documentation(),binding: BindingController());

  }



}

}