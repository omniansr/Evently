import 'package:evently/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowBack extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark? AppTheme.darkblue : AppTheme.white,
          borderRadius: .circular(8),
          border: .all(color: isDark? AppTheme.lightblue : AppTheme.lightgrey)
        ),
        child: SvgPicture.asset(isDark ? 'assets/icons/dark_ArrowBack.svg' : 'assets/icons/light_ArrowBack.svg',
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,),
      ),
    );
  }

}