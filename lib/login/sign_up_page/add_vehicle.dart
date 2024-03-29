import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/controller/binding_controller.dart';
import 'package:driver/controller/user_controller.dart';
import 'package:driver/controller/vehicle_info_controller.dart';
import 'package:driver/login/sign_up_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/color.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {

  List<Map<String, dynamic>> vehicleList = [];
  List<Map<String, dynamic>> brandList = [];
  List<Map<String, dynamic>> modelList = [];



  VehicleController vehicleController = Get.find();
  UserController userController =Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    getData();
  }

  int isSelected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "Enter your vehicle information",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: vehicleList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1.4,
                        crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          isSelected = index;
                          getBrand(vehicleList[index]['id']);

                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                              color:
                                  isSelected == index ? primary : Colors.black12,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                color: Colors.white,
                                child: Image.network(
                                  vehicleList[index]['img'] ?? "",
                                  height: 100,
                                  // width: 50,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                vehicleList[index]['name'] ?? "",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      showAlertBrandDialog(context, brandList);
                    },
                    child: TextFormField(
                      controller: vehicleController.brand,
                      enabled: false,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          color: Colors.red
                        ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)
                          ),
                          hintText: "Brand",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: hintTextColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          contentPadding: const EdgeInsets.all(10)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showAlertModelDialog(context, modelList);
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: vehicleController.model,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          color: Colors.red
                        ),
                          errorBorder: const OutlineInputBorder(
                            borderSide:BorderSide(color: Colors.red)
                          ),
                          hintText: "Model",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: hintTextColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          contentPadding: const EdgeInsets.all(10)),
                      validator: (value) {
                        if(value!.isEmpty) {
                          return "*required";
                        }else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: vehicleController.color,
                    decoration: InputDecoration(
                        hintText: "Color",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: hintTextColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        contentPadding: const EdgeInsets.all(10)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showAlertYearDialog(context);
                    },
                    child: TextFormField(
                      enabled: false,
                      controller: vehicleController.registration,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          color: Colors.red
                        ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)
                          ),
                          hintText: "Car Registration Year",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: hintTextColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          contentPadding: const EdgeInsets.all(10)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*required";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: vehicleController.millage,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Millage",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: hintTextColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        contentPadding: const EdgeInsets.all(10)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: vehicleController.km,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "KM Driven",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: hintTextColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        contentPadding: const EdgeInsets.all(10)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: vehicleController.numberPlate,
                    decoration: InputDecoration(
                        hintText: "Number Plate",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: hintTextColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        contentPadding: const EdgeInsets.all(10)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: vehicleController.passengers,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Number Of Passengers",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: hintTextColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        contentPadding: const EdgeInsets.all(10)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()){

                        FirebaseFirestore.instance.collection("vehicleDetails").add({
                            "vehicle_type" : isSelected==1?"Moto" : isSelected==2?"Economy" : isSelected==3?"Mercado" : "",
                          "brand_type" : vehicleController.brand.text,
                          "model_type" :  vehicleController.model.text,
                          "color_type" : vehicleController.color.text,
                          "registration_year" : vehicleController.registration.text,
                          "driverId":userController.driversDetails['id']
                            }
                        );


                        QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
                            .instance
                            .collection('vehicleDetails')
                            .where("driverId", isEqualTo: userController.driversDetails['id'])
                            .get();

                        if(result.docs.isNotEmpty)
                          {
                            Map data = result.docs[0].data();
                            data['id'] = result.docs[0].id;
                           vehicleController.vehicleDetails.value = data;
                          }

                        Get.to(const Profile(),binding: BindingController());
                      }
                    },

                    child: Container(
                      padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black45,
                              offset: Offset(2,2)
                            )
                          ]
                        ),
                        child: const Icon(Icons.arrow_forward_ios_rounded)),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertBrandDialog(BuildContext context, List<Map<String, dynamic>> list) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              scrollable: true,
              title: const Text(
                "Brand list",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              content: Column(
                children: List.generate(list.length, (index) {
                  return ListTile(
                    style: ListTileStyle.list,
                    onTap: () {
                      vehicleController.brand.text = list[index]['name'];
                      getModel(list[index]['id']);
                      setState(() {});
                      Get.back();
                    },
                    title: Text(
                      list[index]['name'],
                      style:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  );
                }),
              ),
            ));
  }

  showAlertModelDialog(BuildContext context, List<Map<String, dynamic>> list) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              scrollable: true,
              title: const Text(
                "Model list",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              content: Column(
                children: List.generate(list.length, (index) {
                  return ListTile(
                    style: ListTileStyle.list,
                    onTap: () {
                      vehicleController.model.text = list[index]['name'];
                      setState(() {});
                      Get.back();
                    },
                    title: Text(
                      list[index]['name'],
                      style:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  );
                }),
              ),
            ));
  }

  showAlertYearDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              scrollable: true,
          title: const Text("Select Year"),
          content: SizedBox( // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              selectedDate: DateTime.now(),
              onChanged: (DateTime dateTime) {
                vehicleController.registration.text = dateTime.year.toString();
                Navigator.pop(context);
              },
            ),
          ),
            ));
  }

  Future<void> getData() async {
    vehicleList = await vehicleController.getVehicle();
    setState(() {});
  }

  Future<void> getBrand(id) async {
    brandList = await vehicleController.getBrand(id);
    setState(() {});
  }

  Future<void> getModel(id) async {
    modelList = await vehicleController.getModel(id);
    setState(() {});
  }
}
