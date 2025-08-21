import 'package:flutter/material.dart';
import '../../widgets/Cards/content_card_widget.dart';
import '../../widgets/appear/custom_app_bar.dart';
import '../../widgets/appear/custom_bottom_nav.dart';
import '../../widgets/Inputs/search_bar.dart';

class requester_posted_jobs_page extends StatefulWidget {
  const requester_posted_jobs_page({super.key});

  @override
  State<requester_posted_jobs_page> createState() =>
      _requester_posted_jobs_pageState();
}

class _requester_posted_jobs_pageState
    extends State<requester_posted_jobs_page> {
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 239, 237, 237),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                // padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                  color: Color(0xFFFF4CB1),
                ),
                child: const CustomAppBar(),
              ),
              Expanded(child: _bodyCard()),
            ],
          ),
          const Positioned(left: 20, top: 120, child: SearchBarWidget()),
        ],
      ),

      // bottomNavigationBar: ConvexAppBar(
      //   backgroundColor: Colors.transparent,
      //   color: Colors.black,
      //   items: [
      //     TabItem(
      //       icon: Icon(Icons.home, color: Colors.black),
      //       // title: 'Home',
      //     ),
      //     TabItem(
      //       icon: Icon(
      //         Icons.shopping_bag_outlined,
      //         color: Colors.black,
      //       ),
      //     ),
      //     TabItem(icon: Icon(Icons.person, color: Colors.black)),
      //     TabItem(icon: Icon(Icons.settings, color: Colors.black)),
      //   ],
      //   onTap:
      //       (index) => Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => SettingPage()),
      //       ),
      //   // onTap: //* here put navigation depend on the index
      //   //? (ConvexAppBar return index when click on any tabitem)
      // ),
        // bottomNavigationBar:CustomBottomNav()
    
      // bottomNavigationBar: 
        // CustomBottomNav(cureentIndex: 2, userType: 'Provider',)
    
    );
  }
  //! put this  in scaffold body to choose the page depend in the bottom navigation bar index
  // Widget _getSelectedPage(int index) {
  //     switch (index) {
  //       case 0:
  //         return HomePage();
  //       case 1:
  //         return MyLearningWidget(studentId: widget.currentStudentId);
  //       case 2:
  //         return CertificatesWidget();
  //       case 3:
  //         return NotificationsWidget();
  //       default:
  //         return ShowAvailableCoursesWidget(
  //           studentId: widget.currentStudentId,
  //         );
  //     }
  //   }

  // this is bottom navigation bar from package (if you want another)
 
  
  }

  Container _bodyCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 25),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return const Column(
                    children: [
                      SizedBox(height: 15),
                      ContentCardWidget(
                        title: 'Facebook Social Media Design',
                        personName: 'SalahZeft',
                        location: 'Egypt',
                        salary: '150',
                        description:
                            'no desc for now : asdnasa kashbdjas kjdbaS DAKS DKANSD KAN KNAS D ASDKN ASKDN AJLDAKSN DAOJSBDKANSDLOJAsbdo ',
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

 

  

  

