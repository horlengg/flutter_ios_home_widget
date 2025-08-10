import UIKit
import Flutter
import home_widget



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
   GeneratedPluginRegistrant.register(with: self)
    
    // This is required for App Intents (iOS 17+) background updates
    if #available(iOS 17, *) {
    debugPrint("DEBUG: setPluginRegistrantCallback()")
      HomeWidgetBackgroundWorker.setPluginRegistrantCallback { registry in
        GeneratedPluginRegistrant.register(with: registry)
      }
    }
      debugPrint("DEBUG: application()")
    
      print("Main app received URL")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
