import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Registration screen/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'Repository/LanguageModel/setting.dart';
import 'Repository/settings_repository.dart' as settingRepo;
import 'generated/l10n.dart';
import 'notificationservice/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return OverlaySupport(
      child: ValueListenableBuilder(
        valueListenable: settingRepo.setting,
          builder: (context, Setting _setting,_ ) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'service_customer',

              locale: _setting.mobileLanguage.value,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en'), // English
                Locale('hi'), // Spanish
              ],
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: SplashScreen(),
        );
            },
      ),
    );
  }
}
