import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/constant/color.dart';
import 'package:driver/login/sign_up_page/sing_up_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constant/vars.dart';
import '../home/all_rides.dart';
import '../login/login_page/login_otp.dart';
import '../login/sign_up_page/sing_up.dart';

class UserController extends GetxController {
  RxBool isLoaderVisible = false.obs;
  String countryCode = "+91";
  var phone = "";
  String verificationID = "";
  String otp = "";
  TextEditingController phoneNumber = TextEditingController();
  RxMap driversDetails = {}.obs;
  RxBool isOnline = true.obs;

  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  getSingUpOTP(context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode + phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException ex) {
        isLoaderVisible.value = false;

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please Try Again")));
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        isLoaderVisible.value = false;

        Get.to(const SignUpOtp());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  getLoginOTP(context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode + phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException ex) {
        isLoaderVisible.value = false;

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please Try Again")));
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationID = verificationId;
        isLoaderVisible.value = false;

        Get.to(LoginOtp());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        isLoaderVisible.value = false;
      },
    );
  }

  Future<void> verifyLoginOTP() async {
    try {
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);
      FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
            .instance
            .collection('drivers')
            .where("phone_Number", isEqualTo: phoneNumber.text)
            .get();
        if (result.docs.isEmpty) {
          Get.to(SingUp(phoneNumber: phoneNumber.text));
        } else {
          GetStorage().write("isLogin", true);
          driversDetails.value = result.docs[0].data();
          driversDetails['id'] = result.docs[0].id;
          GetStorage().write("driversDetails", driversDetails);
          Get.offAll(const AllRides());
        }
      }).onError((error, stackTrace) {
        isLoaderVisible.value = false;
        Fluttertoast.showToast(
            msg: "InVaild OTP",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } catch (ex) {
      log(ex.toString());
    }
  }

  Future<void> verifySingUpOTP() async {
    try {
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);
      FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
            .instance
            .collection('drivers')
            .where("phone_Number", isEqualTo: phoneNumber.text)
            .get();
        if (result.docs.isEmpty) {
          Get.to(SingUp(phoneNumber: phoneNumber.text));
        } else {
          GetStorage().write("isLogin", true);
          driversDetails.value = result.docs[0].data();
          driversDetails['id'] = result.docs[0].id;
          GetStorage().write("driversDetails", driversDetails);
          Get.off(const AllRides());
        }
      }).onError((error, stackTrace) {
        isLoaderVisible.value = false;
        Fluttertoast.showToast(
            msg: "InVaild OTP",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } catch (ex) {
      log(ex.toString());
    }
  }

  showAlertNameDialog(BuildContext context, String value) {
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
            .collection("drivers")
            .doc(driversDetails['id'])
            .update({'first_name': textEditingController.text});

        QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
            .instance
            .collection('drivers')
            .where("phone_Number", isEqualTo: driversDetails['phone_Number'])
            .get();
        driversDetails.value = result.docs[0].data();
        driversDetails['id'] = result.docs[0].id;

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

  showAlertLastNameDialog(BuildContext context, String value) {
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
            .collection("drivers")
            .doc(driversDetails['id'])
            .update({'last_name': textEditingController.text});

        QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
            .instance
            .collection('drivers')
            .where("phone_Number", isEqualTo: driversDetails['phone_Number'])
            .get();
        driversDetails.value = result.docs[0].data();
        driversDetails['id'] = result.docs[0].id;

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

  showAlertPasswordDialog(BuildContext context) {
    TextEditingController passwordAlert = TextEditingController();

    // set up the buttons

    Widget saveButton = TextButton(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          decoration: BoxDecoration(
              color: primary, borderRadius: BorderRadius.circular(8)),
          child: const Text(
            "SAVE",
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          )),
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
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
        child: Text("Change Password",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onChanged: (value) {
                if (password.text == currentPassword.text) {
                  isPasswordMatched = true;
                } else {
                  isPasswordMatched = false;
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "required";
                } else if (!isPasswordMatched) {
                  return "Password not matched";
                } else {
                  return null;
                }
              },
              controller: passwordAlert,
              decoration: InputDecoration(
                  hintText: 'Current Password',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: hintTextColor),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: newPassword,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "required";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  hintText: 'New Password',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: hintTextColor),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                } else if (!isPasswordMatched) {
                  return "Password filed do not match";
                } else {
                  return null;
                }
              },
              controller: confirmNewPassword,
              decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: hintTextColor),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ],
        ),
      ),
      actions: [
        saveButton,
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
