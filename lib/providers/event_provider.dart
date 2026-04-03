import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';

/*class EventProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];


  Future<void> getEvents() async{
    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;
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

 */


import 'package:evently/firebase_service.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> allFavoriteEvents = [];
  List<EventModel> displayedFavoriteEvents = [];


  Future<void> getEvents() async {

    allEvents = await FirebaseService.getEvents();
    displayedEvents = allEvents;

    notifyListeners();
  }

  Future<void> filterEvents(CategoryModel? category) async {

    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents = allEvents
          .where((event) => event.category == category)
          .toList();
    }

    notifyListeners();
  }

  void clearEvents() {
    allEvents.clear();
    displayedEvents.clear();
    notifyListeners();
  }

  void updateEventInProvider(EventModel updatedEvent) {
    int index = allEvents.indexWhere((e) => e.id == updatedEvent.id);
    if (index != -1) {
      allEvents[index] = updatedEvent;
      displayedEvents = allEvents;
      notifyListeners();
    }
  }

  void deleteEventInProvider(String eventId) {
    allEvents.removeWhere((e) => e.id == eventId);
    displayedEvents = allEvents;
    notifyListeners();
  }

  void filterFavoriteEvents(List<String> favoriteEventsIds){
    allFavoriteEvents = allEvents.where((event) => favoriteEventsIds.contains(event.id)).toList();
    displayedFavoriteEvents = allFavoriteEvents;
    notifyListeners();
  }

  void searchFavoriteEvents( String query){
    displayedFavoriteEvents = allFavoriteEvents
        .where((event) =>
        event.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}