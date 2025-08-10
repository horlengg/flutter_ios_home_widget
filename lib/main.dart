
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

const appGroupID = 'group.lenghomewidget';
const _countKey = 'counter';

/// Gets the currently stored Value
Future<int> get _value async {
  final value = await HomeWidget.getWidgetData<int>(_countKey, defaultValue: 0);
  return value!;
}

/// Retrieves the current stored value
/// Increments it by one
/// Saves that new value
/// @returns the new saved value
Future<void> _increment() async {
  final value = await _value;
  await _sendAndUpdate(value + 1);
}

/// Clears the saved Counter Value
Future<void> _decrement() async {
  final oldValue = await _value;
  await _sendAndUpdate(oldValue - 1);
}

/// Stores [value] in the Widget Configuration
Future<void> _sendAndUpdate([int? value]) async {
  await HomeWidget.saveWidgetData(_countKey, value);
  await HomeWidget.updateWidget(
    iOSName: 'DemoWidget',
  );
}

@pragma("vm:entry-point")
FutureOr<void> backgroundCallback(Uri? uri) async {
  debugPrint('backgroundCallback() : $uri');
   if (uri?.host == 'increment') {
    _increment();
  } else if (uri?.host == 'decrement') {
    _decrement();
  }
}


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeWidget.setAppGroupId(appGroupID);
  await HomeWidget.registerInteractivityCallback(backgroundCallback);
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initHomeWidget();
  }

  void _handleLinkHomeWidgetApp(Uri? uri){
    debugPrint("_handleLinkHomeWidgetApp() : $uri");
    if(uri == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        navigatorKey.currentState?.pushNamed('/${uri.host}');
      });
    });

  }

  Future<void> _initHomeWidget() async {
    final launchedFromWidget = await HomeWidget.initiallyLaunchedFromHomeWidget();
    _handleLinkHomeWidgetApp(launchedFromWidget);
    HomeWidget.widgetClicked.listen((uri) {
      _handleLinkHomeWidgetApp(uri);
    });
    debugPrint('Launched from widget: $launchedFromWidget');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/func_scan_qr': (context) => const ScanQRPage(),
        '/func_show_qr': (context) => const ShowQRPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Page",style: TextStyle(fontSize: 24,color: Colors.green)),
      ),
    );
  }
}

class ScanQRPage extends StatelessWidget {
  const ScanQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Scan QR Page",style: TextStyle(fontSize: 24,color: Colors.green)),
      ),
    );
  }
}
class ShowQRPage extends StatelessWidget {
  const ShowQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Show QR Page",style: TextStyle(fontSize: 24,color: Colors.green)),
      ),
    );
  }
}