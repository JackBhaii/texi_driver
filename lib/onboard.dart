import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constant/color.dart';
import 'constant/text.dart';
import 'login/login.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  Map<String, dynamic> slider1 = {
    "Image": "assets/img/intro_1.png",
    "Title": introTitle1,
    "SubTitle": introSubtitle1
  };
  Map<String, dynamic> slider2 = {
    "Image": "assets/img/intro_2.png",
    "Title": introTitle2,
    "SubTitle": introSubtitle2
  };
  Map<String, dynamic> slider3 = {
    "Image": "assets/img/intro_3.png",
    "Title": introTitle3,
    "SubTitle": introSubtitle3
  };

  List<Map<String, dynamic>> sliderList = [];
  int currentPage=0;
  PageController pageController=PageController();

  final storage = GetStorage();


  @override
  void initState() {

    super.initState();
    sliderList.addAll([slider1, slider2, slider3]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: sliderList.length,
            onPageChanged: (int index){
              currentPage=index;
              setState(() {

              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Image.asset(sliderList[index]['Image']),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    sliderList[index]['Title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        letterSpacing: 1.2),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    sliderList[index]['SubTitle'],
                    style: const TextStyle(
                      color: Colors.black45,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  currentPage!=2?
                      InkWell(
                        onTap: () {
                          pageController.animateToPage(2, duration: const Duration(milliseconds: 400) , curve:Curves.easeIn);
                        },
                        child: const Text("Skip",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1.5,
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.w900)
                        ),
                      ) :

                  InkWell(
                    onTap: () {
                      Get.off(const Login());
                      storage.write("isFirstTime", false);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Text("Get Started",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w900)
                      ),
                    ),
                  ),


                  const SizedBox(height:30 ),
                  SizedBox(
                    height: 10,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: sliderList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            currentPage=index;
                            pageController.animateToPage(currentPage, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                            setState(() {

                            });
                          },
                          child: Container(
                              width: 40,
                              height: 5,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                   color: index==currentPage?Colors.yellow:Colors.grey)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
