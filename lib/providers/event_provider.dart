import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];


  Future<void> getEvents() async{
    allEvents = await FirebaseService.getEvents();
    notifyListeners();
  }

  Future<void> filterEvents(CategoryModel? category) async{
    if(category == null)
      {
        displayedEvents = allEvents;
      }
    else
      {
        displayedEvents = allEvents.where((event) => event.category == category)
            .toList();
      }
    notifyListeners();

  }

}