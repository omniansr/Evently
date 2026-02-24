import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  IconData? icon;
  String? iconPath;
  String lightImage;
  String darkImage;

  CategoryModel({
    required this.id,
    required this.name,
    required this.lightImage,
    required this.darkImage,
    this.icon,
    this.iconPath
});

  static List<CategoryModel> categories = [
   CategoryModel(id: '1', name: 'Sport', lightImage: 'assets/images/Sport.png',
       darkImage: 'assets/images/DSport.png',iconPath: 'assets/icons/sport.svg'),
    CategoryModel(id: '2', name: 'Birthday', lightImage: 'assets/images/Birthday.png',
        darkImage: 'assets/images/DBirthday.png',iconPath: 'assets/icons/birthday.svg'),
    CategoryModel(id: '3', name: 'Book Club', lightImage: 'assets/images/Book_Club.png',
        darkImage: 'assets/images/DBook_Club.png',iconPath: 'assets/icons/book.svg'),
    CategoryModel(id: '4', name: 'Meeting', lightImage: 'assets/images/Meeting.png',
        darkImage: 'assets/images/DMeeting.png',icon: Icons.meeting_room),
    CategoryModel(id: '5', name: 'Exhibition', lightImage: 'assets/images/Exhibition.png',
        darkImage: 'assets/images/DExhibition.png',icon: Icons.event),

  ];

}