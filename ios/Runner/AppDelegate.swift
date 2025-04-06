import UIKit
import Flutter
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

//     FirebaseApp.configure()

    // Request permission to display alerts and play sounds.
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            print("Permission granted")
        } else if let error = error {
            print("Error requesting authorization: \(error.localizedDescription)")
        }
    }

    application.registerForRemoteNotifications()

//     Messaging.messaging().delegate = self

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

//   override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        Messaging.messaging().apnsToken = deviceToken
//   }

//   override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//       completionHandler([.alert, .sound, .badge])
//   }

//   override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//       // Handle the notification response here
//       completionHandler()
//   }

//   func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//       if let fcmToken = fcmToken {
//           print("Firebase registration token: \(fcmToken)")
//           // Send this token to your server or save it as needed
//       }
//   }
}
