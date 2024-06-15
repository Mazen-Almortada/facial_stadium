import 'package:facial_stadium/core/styles/app_colors.dart';
import 'package:facial_stadium/core/styles/app_text_style.dart';
import 'package:facial_stadium/core/widgets/app_bar.dart';
import 'package:facial_stadium/core/widgets/brand_name_widget.dart';
import 'package:facial_stadium/core/widgets/custom_button.dart';
import 'package:facial_stadium/core/widgets/custom_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(
          title: const BrandNameWidget(textSize: 15),
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Image.asset('assets/Picture1.png'),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.newspaper,
                    size: 30,
                  ),
                  Image.asset(
                    'assets/search.png',
                    height: 35,
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              _selectedIndex == 4
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                          onPressed: () async {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.signOut();
                            Get.offAllNamed("/onboarding");
                          },
                          text: "Logout"),
                    )
                  : Center(
                      child: CustomTextsWidget(
                        text: "No News",
                        style: AppTextStyle.primaryTextStyle(
                            bold: true, color: Colors.white, size: 20),
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 80,
            margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
            decoration: BoxDecoration(
              color: const Color(0xff3a603d),
              borderRadius: BorderRadius.circular(40),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: 'News',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'My History',
                ),
                BottomNavigationBarItem(
                  icon:
                      Container(), // Empty container to center the floating button
                  label: '',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.airplane_ticket_outlined),
                  label: 'My Ticket',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            child: FloatingActionButton(
              backgroundColor: const Color(0xff90ec9f),
              onPressed: () {},
              elevation: 0,
              child: const Icon(Icons.add, size: 35, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
