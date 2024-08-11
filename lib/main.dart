// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_super_parameters

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:tradeiq/Components/market_status.dart';
import 'package:tradeiq/Screens/Pages/EconomicCalendar.dart';
import 'package:tradeiq/Screens/Tools/SearchStockes.dart';
import 'package:tradeiq/Services/Messaging.dart';
import 'package:tradeiq/Utils/Functions.dart';
import 'Provider/Variable.dart';
import 'Services/CheckAuthServices.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingAPI().initializeNotifications();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final quickActions = QuickActions();

  // Show the quick actions when the app is opened 
  @override
  void initState() {
    super.initState();
    quickActions.setShortcutItems([
      ShortcutItem(type: 'Search', localizedTitle: 'Search'),
      ShortcutItem(type: 'Calendar', localizedTitle: 'Economic Calendar'),
      ShortcutItem(type: 'Status', localizedTitle: 'Market Status'),
    ]);

    quickActions.initialize((type) {
      if (type == 'Search') {
        moveNextPage(context, SearchStockScreen());
      } else if (type == 'Calendar') {
        moveNextPage(context, EconomicCalendarPage());
      } else if (type == 'Status') {
        moveNextPage(context, MarketStatusWidget());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TradeIQ',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => NavBarVisibility(),
          ),
        ],
        child: AuthWrapper(),
      ),
    );
  }
}
