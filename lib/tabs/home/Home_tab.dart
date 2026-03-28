import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:evently/widgets/event_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);

    return Column(
        children: [
          HomeHeader(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (_,index) => EventItem(eventProvider.displayedEvents[index]),
                separatorBuilder:(_,_) => SizedBox(height: 16,),
                itemCount: eventProvider.displayedEvents.length),
          )
        ],

    );
  }

}