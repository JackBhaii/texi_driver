import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/controller/binding_controller.dart';
import 'package:driver/login/sign_up_page/profile_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../constant/color.dart';
import '../../controller/document_controller.dart';
import '../../controller/user_controller.dart';
import '../../home/all_rides.dart';

class Documentation extends StatefulWidget {
  const Documentation({super.key});

  @override
  State<Documentation> createState() => _DocumentationState();
}

class _DocumentationState extends State<Documentation> {
  final ImagePicker picker = ImagePicker();




  UserController userController=Get.find();

  DocumentController documentController =Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.05,
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
              height: Get.height * 0.04,
            ),
            const Text(
              "Add Verification Document",
              style: TextStyle(
                  letterSpacing: 1, fontWeight: FontWeight.w900, fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Driving Lc",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // userController.isLoaderVisible.value=true;
                    documentController.dPhoto = await picker.pickImage(source: ImageSource.gallery);
                    final storageRef = FirebaseStorage.instance.ref();
                    String  currentTime=DateTime.now().toString();
                    final mountainsRef = storageRef.child("$currentTime.jpg");
                    File file = File(documentController.dPhoto!.path);
                    await mountainsRef.putFile(file);
                    documentController.dPath =await mountainsRef.getDownloadURL();
                    // userController.isLoaderVisible.value=false;
                    setState(() {});

                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: blue, borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Upload",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            documentController.dPhoto != null ? Image.file(File(documentController.dPhoto!.path),
              width: double.maxFinite,
              height: 100,
              fit: BoxFit.cover,
            ):const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "RC Book",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    documentController.rPhoto = await picker.pickImage(source: ImageSource.gallery);
                    final storageRef = FirebaseStorage.instance.ref();
                    String  currentTime=DateTime.now().toString();
                    final mountainsRef = storageRef.child("$currentTime.jpg");
                    File file = File(documentController.rPhoto!.path);
                    await mountainsRef.putFile(file);
                    documentController.rPath =await mountainsRef.getDownloadURL();
                    setState(() {});

                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: blue, borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Upload",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            documentController.rPhoto != null ? Image.file(File(documentController.rPhoto!.path),
              width: double.maxFinite,
              height: 100,
              fit: BoxFit.cover,
            ):const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Insurance",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    documentController.iPhoto = await picker.pickImage(source: ImageSource.gallery);
                    final storageRef = FirebaseStorage.instance.ref();
                    String  currentTime=DateTime.now().toString();
                    final mountainsRef = storageRef.child("$currentTime.jpg");
                    File file = File(documentController.iPhoto!.path);
                    await mountainsRef.putFile(file);
                    documentController.iPath =await mountainsRef.getDownloadURL();
                    setState(() {});

                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: blue, borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Upload",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            documentController.iPhoto != null ? Image.file(File(documentController.iPhoto!.path),
              width: double.maxFinite,
              height: 100,
              fit: BoxFit.cover,
            ):const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "PUC",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    documentController.pPhoto = await picker.pickImage(source: ImageSource.gallery);
                    final storageRef = FirebaseStorage.instance.ref();
                    String  currentTime=DateTime.now().toString();
                    final mountainsRef = storageRef.child("$currentTime.jpg");
                    File file = File(documentController.pPhoto!.path);
                    await mountainsRef.putFile(file);
                    documentController.pPath =await mountainsRef.getDownloadURL();
                    setState(() {});

                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: blue, borderRadius: BorderRadius.circular(5)),
                    child: const Text(
                      "Upload",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            documentController.pPhoto != null ? Image.file(File(documentController.pPhoto!.path),
              width: double.maxFinite,
              height: 100,
              fit: BoxFit.cover,
            ):const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(color: Colors.white),
            child: InkWell(
              onTap: () {
                documentController.checkDoc();

              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: blue),
                child: const Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
