import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifications_test/main.dart';

class FirebaseApi {
  // create an instance of fbmessaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notif

  Future<void> initNotificationsServices() async {
    //requesting permissions
    await _firebaseMessaging.requestPermission();

    //get FCM token

    final String? fcmToken = await _firebaseMessaging.getToken();

    //print token

    print("FCM token pana: $fcmToken");
    initNotificationsServices();
  }

  //function to handle new messages

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed("/notif", arguments: message);
  }

  //function to initialize  background setts
  Future initPushNotifications() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => handleMessage(value));

    FirebaseMessaging.onMessageOpenedApp
        .listen((value) => handleMessage(value));
  }
}
