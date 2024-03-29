import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/home/all_rides.dart';
import 'package:driver/login/sign_up_page/sing_up_phone.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constant/color.dart';
import '../controller/binding_controller.dart';
import '../controller/user_controller.dart';
import 'forgot_page.dart';
import 'login_page/login_number.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  double shadow = 0;
  final _formKey = GlobalKey<FormState>();
  UserController userController =Get.find();
  final strong = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/img/bg_img.png",
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height * 0.20,
                    ),
                    const Center(
                        child: Text("Login With Email",
                            style: TextStyle(
                                letterSpacing: 0.60,
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600))),
                    Container(
                      height: 3,
                      width: 80,
                      margin: const EdgeInsets.only(top: 8),
                      color:primary,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      color: Colors.white,
                      child:  TextFormField(
                        validator: (value) {
                          if (value!.isEmpty){
                            return"Enter email";
                          }
                          else if (value.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)){
                            return "Enter valid  email!";
                          }else  {
                            return null;
                          }
                        },
                        controller: userController.email,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12)
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          hintStyle: TextStyle(
                            fontWeight:FontWeight.w600,
                            fontSize: 14
                          )
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: Colors.white,
                      child:  TextField(
                        controller: userController.password,
                        decoration: const InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12)
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            hintStyle: TextStyle(
                                fontWeight:FontWeight.w600,
                                fontSize: 14
                            )
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Card(
                      elevation: shadow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Material(
                        color:primary,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(

                          onTapUp: (val) {
                            Future.delayed(const Duration(milliseconds: 500),(){
                              shadow = 0;
                              setState(() {});
                            });
                          },
                          onTap: () async {
                            shadow = 6;
                            setState(() {});
                            if (_formKey.currentState!.validate()){
                              QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
                                  .instance
                                  .collection('drivers')
                                  .where("email", isEqualTo: userController.email.text)
                                  .get();
                              if (result.docs.isNotEmpty) {
                                if(userController.password.text == result.docs[0]['password']){
                                  strong.write("isLogin", true);
                                  userController.driversDetails.value = result.docs[0].data();
                                  userController.driversDetails['id'] = result.docs[0].id;
                                  strong.write("driversDetails", userController.driversDetails.value);
                                  Get.to(const AllRides());
                                }else{
                                  Fluttertoast.showToast(
                                      msg:"Wrong Password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg:"Please SingUp ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }

                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),

                            ),
                            child: const Center(
                              child: Text("LOG IN",
                                  style: TextStyle(
                                    fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.to(const ForgotPage());
                        },
                        child:  Text("Forgot your password?",
                          style: TextStyle(
                              color: primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w900
                          ),),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Get.to(const LoginNumber(),binding: BindingController());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border.all(color: primary ),
                            borderRadius: BorderRadius.circular(8),

                          ),
                          child:  Center(
                            child: Text("Login With Phone Number",
                                style: TextStyle(
                                  fontSize: 12,
                                    color: primary,
                                    fontWeight: FontWeight.w900)),
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

      bottomNavigationBar:
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/img/bg_img.png"),
            fit: BoxFit.cover
            )
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.to( SingUpPhone(),binding: BindingController());
            },
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You don't hve an account yet?",
                  style: TextStyle(
                    fontSize: 12
                  ),
                  ),
                  Text("SIGNUP",
                    style:TextStyle(
                      fontSize: 12,
                        color: primary
                    ) ,)
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
