import 'package:flutter/material.dart';
import 'package:video_app/pages/home/explore.dart';

class HomeScreen extends StatefulWidget {
  static String Name = "";
  static String Phone = "";
  static String Email = "";
  static String DOB = "";
  static bool isLogIn = true;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var activeScreen = 0;

  @override
  void initState() {
    // TODO: implement initState
    HomeScreen.isLogIn = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ExploreScreen(),
            ),

            //Top and bottom bar
            Column(
              children: [
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 253, 253, 253),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 253, 253, 253),
                          blurRadius: 16)
                    ],
                  ),
                  child: Row(children: [
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.notification_add,
                        size: 28,
                        color: Colors.red,
                      ),
                    )
                  ]),
                ),
                Spacer(),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            activeScreen = 0;
                            print(activeScreen);
                          });
                        },
                        child: Icon(
                          Icons.explore,
                          size: 40,
                          color: activeScreen == 0
                              ? Color.fromARGB(255, 255, 231, 75)
                              : Colors.white,
                          shadows: activeScreen == 0
                              ? [
                                  BoxShadow(
                                      color: Color.fromARGB(144, 0, 0, 0),
                                      offset: Offset(1, 2),
                                      blurRadius: 16)
                                ]
                              : null,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            activeScreen = 1;
                            print(activeScreen);
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: 40,
                          color: activeScreen == 1
                              ? Color.fromARGB(255, 255, 231, 75)
                              : Colors.white,
                          shadows: activeScreen == 1
                              ? [
                                  BoxShadow(
                                      color: Color.fromARGB(144, 0, 0, 0),
                                      offset: Offset(1, 2),
                                      blurRadius: 16)
                                ]
                              : null,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            activeScreen = 2;
                            print(activeScreen);
                          });
                        },
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: activeScreen == 2
                              ? Color.fromARGB(255, 255, 231, 75)
                              : Colors.white,
                          shadows: activeScreen == 2
                              ? [
                                  BoxShadow(
                                      color: Color.fromARGB(144, 0, 0, 0),
                                      offset: Offset(1, 2),
                                      blurRadius: 16)
                                ]
                              : null,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
