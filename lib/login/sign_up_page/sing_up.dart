import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/controller/binding_controller.dart';
import 'package:driver/login/sign_up_page/sing_up_phone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/color.dart';
import '../../controller/user_controller.dart';
import '../login.dart';
import 'add_vehicle.dart';

class SingUp extends StatefulWidget {
  final String phoneNumber;
    SingUp({super.key, required this.phoneNumber});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {

  UserController userController= Get.find();

  bool isPasswordMatched=false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/img/bg_img.png",
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height*0.05,
                    ),
                    Card(
                      elevation: 8,
                      shape: const CircleBorder(),
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              Get.back();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back_ios_new),
                            )),
                      ),
                    ),
                     SizedBox(
                      height: Get.height*0.08,
                    ),
                    const Center(
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              letterSpacing: 1.2,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        )),
                    Center(
                      child: Container(
                          height: 3,
                          width: 90,
                          margin: const EdgeInsets.only(top: 8),
                          color: primary),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: userController.name,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: hintTextColor),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black))
                            ),

                            validator: (value) {
                              if(value!.isEmpty) {
                                return "required";
                              } else {
                                return null;
                              }
                            },

                          ),
                        ),
                        SizedBox(
                          width: Get.width*0.02,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: userController.lastName,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                              hintText: "Last Name",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: hintTextColor),
                                border:  OutlineInputBorder(
                                    borderSide: BorderSide(color: textFieldBoarderColor))
                            ),
                            validator: (value) {
                              if(value!.isEmpty) {
                                return "required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      enabled: false,
                      controller: TextEditingController(text: userController.phoneNumber.text),
                      decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600, color: hintTextColor),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: userController.email,
                      decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontSize: 14,
                              fontWeight: FontWeight.w600, color: hintTextColor),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter email";
                        } else if (value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return "enter email!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: userController.password,
                      decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontSize: 14,
                              fontWeight: FontWeight.w600, color: hintTextColor),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "enter Password ";
                        } else if (value.length < 6) {
                          return "*required at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: userController.confirmPassword,
                      onChanged: (String value) {
                        if (userController.password.text == userController.confirmPassword.text) {
                          isPasswordMatched = true;
                        } else {
                          isPasswordMatched = false;
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter confirm password";
                        } else if (!isPasswordMatched) {
                          return "*password not matched";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                            fontSize: 14,
                              fontWeight: FontWeight.w600, color: hintTextColor),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: primary,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          if (_formKey.currentState!.validate()){
                            FirebaseFirestore.instance.collection("drivers").add(
                              {
                                'first_name': userController.name.text,
                                'last_name' : userController.lastName.text,
                                'email': userController.email.text,
                                'phone_Number': userController.phoneNumber.text,
                                'password': userController.password.text,
                              }
                            );
                            QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore.instance.collection('drivers').where("phone_Number",isEqualTo:userController.phoneNumber.text).get();
                            if(result.docs.isNotEmpty){
                              userController.driversDetails.value =result.docs[0].data();
                              userController.driversDetails['id']=result.docs[0].id;
                            }

                            Get.to(const AddVehicle(),binding: BindingController());

                          }

                        },
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Center(
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            image:
            DecorationImage(image: AssetImage("assets/img/bg_img.png",),
            fit: BoxFit.cover
            )),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
             Get.off(Login());
            },
            child:  Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                  style: TextStyle(
                    fontSize: 12
                  ),
                  ),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 12,
                        color: primary),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
