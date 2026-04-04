import 'package:evently/create_event_screen.dart';
import 'package:evently/nav_bar_icon.dart';
import 'package:evently/tabs/favorite/favorite_tab.dart';
import 'package:evently/tabs/home/Home_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs =[
    HomeTab(),
    FavoriteTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: tabs[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
          onTap: (index){
            if (currentIndex == index) return;
            currentIndex = index;
          setState(() {});
          },
          items: [
            BottomNavigationBarItem(label:'Home' ,icon: NavBarIcon(imageName: 'unselectedhome',),
            activeIcon: NavBarIcon(imageName: 'selectedhome')),
            BottomNavigationBarItem(label:'Favorite' ,icon: NavBarIcon(imageName: 'unselectedheart'),
                activeIcon: NavBarIcon(imageName: 'selectedheart')),
            BottomNavigationBarItem(label:'Profile' ,icon: NavBarIcon(imageName: 'unselecteduser',),
                activeIcon: NavBarIcon(imageName: 'selecteduser')),
          ]
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed(CreateEventScreen.routename).then((_){
        });
      },
      child: Icon(Icons.add,size: 28,),),
    );
  }
}