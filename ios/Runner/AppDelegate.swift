import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
       var apiKey: String {
        get {
          guard let filePath = Bundle.main.path(forResource: "keys", ofType: "plist") else {
            fatalError("Couldn't find file 'Keys.plist'.")
          }
          let plist = NSDictionary(contentsOfFile: filePath)
          guard let value = plist?.object(forKey: "GOOGLE_MAPS_API_KEY") as? String else {
            fatalError("Couldn't find key 'GOOGLE_MAPS_API_KEY' in 'Keys.plist'.")
          }
          return value
        }
      }
          GMSServices.provideAPIKey(apiKey)
          GeneratedPluginRegistrant.register(with: self)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }
  }
