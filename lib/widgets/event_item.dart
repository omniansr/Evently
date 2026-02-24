import 'package:evently/app_theme.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventItem  extends StatelessWidget{

 // CategoryModel category;

  //EventItem({required this.category});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Size screenSize = MediaQuery.sizeOf(context);

    return Stack(
     children: [
       Container(
         decoration: BoxDecoration(
           border: .all(color: isDark? AppTheme.lightblue: AppTheme.lightgrey),
           borderRadius: .circular(16)
         ),
         child: ClipRRect(
           borderRadius: .circular(16),
           child: Image.asset(isDark? 'assets/images/DSport.png':'assets/images/Sport.png',
           height: screenSize.height * 0.23,
           width: double.infinity,
           fit: .fill,
           ),
         ),
       ),
       Container(
         margin: EdgeInsets.only(top: 8,left: 8),
         padding: EdgeInsets.all(8),
         decoration: BoxDecoration(
           color: isDark? AppTheme.darkBlack : AppTheme.offwhite,
           borderRadius: .circular(8),
           border: .all(color: isDark? AppTheme.lightblue: AppTheme.lightgrey)
         ),
         child: Text('21 jan',style:
           textTheme.titleMedium!.copyWith(fontWeight: .w600,color: primaryColor)
       ),
       ),
       Positioned(
         width: screenSize.width - 32,
         bottom: 8,
           child: Container(
             margin: EdgeInsets.symmetric(horizontal: 8),
             padding: EdgeInsets.all(8),
             decoration: BoxDecoration(
                 color: isDark? AppTheme.darkBlack : AppTheme.offwhite,
                 borderRadius: .circular(8),
                 border: .all(color: isDark? AppTheme.lightblue: AppTheme.lightgrey)
               ),
             child: Row(
               children: [
                 Expanded(child: Text("this is a party",
                   style: isDark?
                   textTheme.titleSmall!.copyWith(fontWeight: .w500,color: AppTheme.white)
                       :textTheme.titleSmall!.copyWith(fontWeight: .w500,color: AppTheme.black),
                 ),
                 ),
                 SizedBox(width: 8,),
                 SvgPicture.asset('assets/icons/unselectedheart.svg',color: primaryColor),
               ],
             ),
           ),
       ),
     ],
   );
  }
}