import 'package:evently/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarActions extends StatelessWidget {
  String svgName;
  bool isEdit;

  AppBarActions({required this.svgName, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: isDark ? AppTheme.darkblue : AppTheme.white,
            borderRadius: .circular(8),
            border: .all(
                color: isDark ? AppTheme.lightblue : AppTheme.lightgrey)
        ),
        child: SvgPicture.asset(
             'assets/icons/${svgName}.svg',
          colorFilter: isEdit ? ColorFilter.mode(primaryColor, BlendMode.srcIn):null,
          width: 24,
          height: 24,
          fit: BoxFit.scaleDown,),
    );
  }
}