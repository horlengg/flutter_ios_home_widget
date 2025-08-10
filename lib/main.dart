
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeWidget.setAppGroupId('group.lenghomewidget');
  await HomeWidget.registerInteractivityCallback(backgroundCallback);
  runApp(const MyApp());
}

@pragma("vm:entry-point")
FutureOr<void> backgroundCallback(Uri? data) async {
  // do something with data
  print('backgroundCallback() : $data'); // Works even outside State
   debugPrint('backgroundCallback() : $data');
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