
import 'package:flutter/material.dart';
import 'package:puyitha/MyThemes/mytheme.dart';
import 'package:puyitha/constant/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 12, 60, 84),
      body: pageIndex[pageIdx],
      bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIdx,
            onTap: (value) {
              setState(() {
                pageIdx = value;
              });
            },
            elevation: 30,
            selectedItemColor: Color.fromARGB(255, 203, 80, 121),
            unselectedItemColor: Colors.grey,
            backgroundColor:const Color.fromARGB(34, 239, 232, 232),
            items:const [
               BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 23,
                ),
                label: "Home",
              ),
               BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category,
                    size: 23,
                  ),
                  label: "Categories"),
                   BottomNavigationBarItem(
                  icon: Icon(
                    Icons.card_travel,
                    size: 23,
                  ),
                  label: "Cart"),
             
               BottomNavigationBarItem(
                  icon: Icon(
                    Icons.switch_access_shortcut,
                    size: 23,
                  ),
                  label: "Social"),
                    BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 23,
                  ),
                  label: "Me")
            ]),
    );
  }
}