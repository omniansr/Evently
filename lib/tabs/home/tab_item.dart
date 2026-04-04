import 'package:evently/app_theme.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabItem extends StatelessWidget {
  bool isSelected;
  String name;
  IconData? icon;
  String? iconPath;

  TabItem({required this.name,required this.isSelected, this.icon,this.iconPath});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
        color: isSelected ? primaryColor
        : isDark? AppTheme.darkblue : AppTheme.white,
          border: BoxBorder.all(color: isSelected? primaryColor : isDark? AppTheme.lightblue : AppTheme.lightgrey )
    ),
      child: Row(
        children: [
           iconPath != null ?
          SvgPicture.asset(iconPath!,colorFilter: ColorFilter.mode(
              isSelected? AppTheme.white :
              primaryColor
              , BlendMode.srcIn),width: 24,height: 24,):
          Icon(icon,color: isSelected? AppTheme.white :
            primaryColor,),
          SizedBox(width: 8,),
          Text(name,style: isDark?
          textTheme.titleMedium!.copyWith(color: AppTheme.white  ,fontWeight:FontWeight.w500 )
            :textTheme.titleMedium!.copyWith(color: isSelected ? AppTheme.white: AppTheme.black,
              fontWeight:FontWeight.w500 ),)
        ],
      ),
    );
    
  }
  
}