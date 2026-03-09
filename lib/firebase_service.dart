import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventCollection() =>
   FirebaseFirestore.instance.collection('events')
      .withConverter<EventModel>(
  fromFirestore: (snapshot,_) { EventModel event =  EventModel.fromJson(snapshot.data()!);
    event.id = snapshot.id;
    return event;
    },
  toFirestore: (event,_) => event.toJson(),
  );

  static Future<void> createEvent (EventModel event){
    CollectionReference<EventModel> eventCollection = getEventCollection();
   DocumentReference<EventModel> doc =  eventCollection.doc();
   event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async{
    CollectionReference<EventModel> eventsCollection = getEventCollection();
    QuerySnapshot<EventModel> querySnapshot = await eventsCollection.orderBy('timestamp').get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> updateEvent (EventModel event){
    CollectionReference<EventModel> eventCollection = getEventCollection();
    return eventCollection.doc(event.id).set(event);
  }

  static Future<void> deleteEvent (EventModel event){
    CollectionReference<EventModel> eventCollection = getEventCollection();
    return eventCollection.doc(event.id).delete();
  }
}

