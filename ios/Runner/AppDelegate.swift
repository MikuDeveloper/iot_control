import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    //Add your Google Maps API key
    GMSServices.provideAPIKey("API_KEY_MAPS")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
