import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../home/all_rides.dart';
import 'binding_controller.dart';

class DocumentController extends GetxController {

  UserController userController= Get.find();

  final ImagePicker picker = ImagePicker();
  XFile? dPhoto;
  String dPath = '';
  XFile? rPhoto;
  String rPath = '';
  XFile? iPhoto;
  String iPath = '';
  XFile? pPhoto;
  String pPath = '';


  drivingLcDoc () {
    if (dPhoto == null) {
      Fluttertoast.showToast(
          msg:"Please Upload Document",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      userController.driversDetails['drivingLc'] = dPath;
      GetStorage().write("isLogin", true);
      GetStorage().write("userDetails",userController.driversDetails);
      FirebaseFirestore.instance.collection('drivers').doc(userController.driversDetails['id']).update(
          {'drivingLc' : dPath});
    }

  }

  rcBookDoc () {
    if (rPhoto == null) {
      Fluttertoast.showToast(
          msg:"Please Upload Document",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      userController.driversDetails['rcBook'] = rPath;
      GetStorage().write("isLogin", true);
      GetStorage().write("userDetails",userController.driversDetails);
      FirebaseFirestore.instance.collection('drivers').doc(userController.driversDetails['id']).update(
          {'rcBook' : rPath});
    }

  }

  insuranceDoc () {
    if (iPhoto == null) {
      Fluttertoast.showToast(
          msg:"Please Upload Document",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      userController.driversDetails['insurance'] = iPath;
      GetStorage().write("isLogin", true);
      GetStorage().write("userDetails",userController.driversDetails);
      FirebaseFirestore.instance.collection('drivers').doc(userController.driversDetails['id']).update(
          {'insurance' : iPath});
    }
  }

  pucDoc () {
    if (pPhoto == null) {
      Fluttertoast.showToast(
          msg:"Please Upload Document",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      userController.driversDetails['insurance'] = pPath;
      GetStorage().write("isLogin", true);
      GetStorage().write("userDetails",userController.driversDetails);
      FirebaseFirestore.instance.collection('drivers').doc(userController.driversDetails['id']).update(
          {'puc' : pPath});
    }
  }

  checkDoc () {
    if (dPhoto==null){
      showToast('Please Upload DrivingLc');
    }else if (rPhoto==null) {
      showToast('Please Upload RC Book');
    } else if (iPhoto==null) {
      showToast('Please Upload Insurance');
    } else if (pPhoto==null) {
      showToast('Please Upload PUC');
    }else {

      drivingLcDoc();
      rcBookDoc();
      insuranceDoc();
      pucDoc();

      Get.to(const AllRides(),binding: BindingController());
    }
  }

  showToast(String msg){
    return  Fluttertoast.showToast(
        msg:msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}