import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> setup() async {
  // #1
  const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

  // #2
  const initSettings = InitializationSettings(android: androidSetting);

  // #3
  await _localNotificationsPlugin.initialize(initSettings).then((_) {
    debugPrint('setupPlugin: setup success');
  }).catchError((Object error) {
    debugPrint('Error: $error');
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setup();
  runApp(const MyApp());
}

// ************************************************************
//    FIRBASE MESSAGING HANDLERS
// ************************************************************
//

// ************************
//  MAIN WIDGET - Statefull
// *********************
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static Color mainColor = const Color(0xFF9D50DD);

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    retrieveToken();
    super.initState();
  }

  retrieveToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("TOKEN $fcmToken");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Awesome Notifications - Simple Example',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Notifications Title"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the Inc button : this many times:',
                ),
                Text(
                  'Diference is : ',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
