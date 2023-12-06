import 'package:flutter/material.dart';
import 'package:maneymanagment/screens/home/screenHome.dart';

class MoneymangmentBottomNavigotion extends StatelessWidget {
  const MoneymangmentBottomNavigotion({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectednotifierIndex,
      builder: (BuildContext context, int updatedIndex, Widget? _) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(0, 130, 121, 121),
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.black ,
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectednotifierIndex.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Transactions",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Category",
              ),
            ],
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            iconSize: 24,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            // backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(size: 28),
            unselectedIconTheme: IconThemeData(size: 24),
          ),
        );
      },
    );
  }
}
