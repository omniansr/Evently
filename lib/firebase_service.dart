import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance.collection('events')
          .withConverter<EventModel>(
        fromFirestore: (snapshot, _) {
          EventModel event = EventModel.fromJson(snapshot.data()!);
          event.id = snapshot.id;
          return event;
        },
        toFirestore: (event, _) => event.toJson(),
      );

  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('users')
          .withConverter<UserModel>(
        fromFirestore: (snapshot, _) {
          UserModel event = UserModel.fromJson(snapshot.data()!);
          event.id = snapshot.id;
          return event;
        },
        toFirestore: (event, _) => event.toJson(),
      );

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventCollection.doc();
    event.id = doc.id;

    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async{
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference<EventModel> eventsCollection = getEventCollection();
    QuerySnapshot<EventModel> querySnapshot = await eventsCollection.orderBy('timestamp').get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> updateEvent(EventModel event) {

    CollectionReference<EventModel> eventCollection = getEventCollection();
    return eventCollection.doc(event.id).set(event);
  }

  static Future<void> deleteEvent(EventModel event) {
    CollectionReference<EventModel> eventCollection = getEventCollection();
    return eventCollection.doc(event.id).delete();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
        id: credential.user!.uid, name: name, email: email,favoriteEventsIds: []);

    CollectionReference<UserModel> userCollection = getUsersCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentSnapshot<UserModel> docSnapshot = await usersCollection.doc(
        credential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<void> addEventToFavorite(String eventId) async{
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentReference<UserModel> userDoc = usersCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({'favoriteEventsIds': FieldValue.arrayUnion([eventId])});
  }

  static Future<void> removeEventFromFavorite(String eventId) async{
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentReference<UserModel> userDoc = usersCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({'favoriteEventsIds': FieldValue.arrayRemove([eventId])});
  }

  static String getCurrentUserId(){
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<UserModel?> loginWithGoogle() async{
      final GoogleSignIn siginIn =  GoogleSignIn.instance;
      siginIn.initialize(serverClientId: '616238932354-vsjcs4bp7h24kp7d2kc3qed9qin3gpik.apps.googleusercontent.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();
      if(googleUser != null) {
        final credential = GoogleAuthProvider.credential(
            idToken: googleUser.authentication.idToken);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);

        UserModel user = UserModel(id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? "",
            email: userCredential.user!.email ?? "",
            favoriteEventsIds: []);

        CollectionReference<UserModel> userCollection = getUsersCollection();
        await userCollection.doc(user.id).set(user);
        return user;
      }
      return null;
  }



}