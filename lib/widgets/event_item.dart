import 'package:evently/app_theme.dart';
import 'package:evently/details_screen.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem  extends StatelessWidget{

  EventModel event;

  EventItem(this.event);


  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    bool isFavorite= userProvider.checkIsFavoriteEvent(event.id);
    Color primaryColor = Theme.of(context).primaryColor;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Size screenSize = MediaQuery.sizeOf(context);


    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(DetailsScreen.routename,arguments: event);
      },
      child: Stack(
       children: [
         Container(
           decoration: BoxDecoration(
             border: .all(color: isDark? AppTheme.lightblue: AppTheme.lightgrey),
             borderRadius: .circular(16)
           ),
           child: ClipRRect(
             borderRadius: .circular(16),
             child: Image.asset(isDark? event.category.darkImage:event.category.lightImage,
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
           child: Text(DateFormat('d MMM').format(event.dateTime),style:
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
                   Expanded(child: Text(event.title,
                     style: isDark?
                     textTheme.titleSmall!.copyWith(fontWeight: .w500,color: AppTheme.white)
                         :textTheme.titleSmall!.copyWith(fontWeight: .w500,color: AppTheme.black),
                   ),
                   ),
                   SizedBox(width: 8,),
                   InkWell(child: isFavorite ? SvgPicture.asset('assets/icons/selectedheart.svg',color: primaryColor)
                   :SvgPicture.asset('assets/icons/unselectedheart.svg',color: primaryColor),
                   onTap: (){
                     if(isFavorite){
                       userProvider.removeEventFromFavorite(event.id);
                       Provider.of<EventProvider>(context,listen: false).filterFavoriteEvents(
                         userProvider.currentUser!.favoriteEventsIds
                       );
                     }else{
                       userProvider.addEventToFavorite(event.id);
                     }

                   },),
                 ],
               ),
             ),
         ),
       ],
         ),
    );
  }
}