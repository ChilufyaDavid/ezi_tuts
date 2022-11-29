# new_app

A new Flutter project.

## Getting Started

This is a practise poject. It will cover various topics across the platforms covered by flutter. The topics covered will have their own git branches.
Topic continuation will be continued under the header-topic branch.

## Master branch
Nothing here, just a defualt flutter app


- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Android android  
## Android Intents android_intents

## 1 - FB - 1  add_firebase
requires firebase_messaging, a plugin to use the Firebase Cloud Messaging(FCM) API
- [Firebase initilisation]
for every firebase project, add firebase_core and initialise app inside main 
DefaultFirebaseOptions - 
    run flutterfire configure in the command prompt, which will connect to the remote firebase projects. This project is using the u_n_i project
Step 4: Add Firebase plugins
    You access Firebase in your Flutter app through the various Firebase Flutter plugins, one for each Firebase product (for example: Cloud Firestore, Authentication, Analytics, etc.).
    Since Flutter is a multi-platform framework, each Firebase plugin is applicable for Apple, Android, and web platforms. So, if you add any Firebase plugin to your Flutter app, it will be used by the Apple, Android, and web versions of your app.

    Here's how to add a Firebase Flutter plugin:

    From your Flutter project directory, run the following command:
        flutter pub add PLUGIN_NAME . 
    then run; flutterfire configure
## 1 - FB - 2  firebase cloud messageing
flutter pub add firebase_messaging
    App is now ready to send fcm messages, you can test from the firebase messaging console.
- [ Receive messages in a Flutter app ]
Depending on a device's state, incoming messages are handled differently. To understand these scenarios and how to integrate FCM into your own application, it is first important to establish the various states a device can be in:

   ~ Foreground: When the application is open, in view and in use.
   ~ Background: When the application is open, but in the background (minimized). This typically occurs when the user has pressed the "home" button on the device, has switched to another app using the app switcher, or has the application open in a different tab (web).
   ~ Terminated: When the device is locked or the application is not running.

 There are a few preconditions which must be met before the application can receive message payloads via FCM:

 ### Message handling

 Based on your application's current state, incoming payloads of different message types require different implementations to handle them:
 - [ Foreground messages ]

 To handle messages while your application is in the foreground, listen to the onMessage stream.

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
            print('Message also contained a notification: ${message.notification}');
        }
    });

    The stream contains a RemoteMessage, detailing various information about the payload, such as where it was from, the unique ID, sent time, whether it contained a notification and more. Since the message was retrieved whilst your application is in the foreground, you can directly access your Flutter application's state and context.

- [ Background messages ]
The process of handling background messages is different on native (Android and Apple) and web based platforms.
Apple platforms and Android
Handle background messages by registering a onBackgroundMessage handler. When messages are received, an isolate is spawned (Android only, iOS/macOS does not require a separate isolate) allowing you to handle messages even when your application is not running.

There are a few things to keep in mind about your background message handler:

  1. It must not be an anonymous function.
  2. It must be a top-level function (e.g. not a class method which requires initialization).
  3. It must be annotated with @pragma('vm:entry-point') right above the function declaration (otherwise it may be removed during tree shaking for release mode).

  @pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

FirebaseMessaging.onBackgroundMessage can also show a message while in terminated state


## Notifications
### flutter_local_notifications
flutter pub add flutter_local_notifications
Android Setup
