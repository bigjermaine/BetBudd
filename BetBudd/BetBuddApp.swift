//
//  BetBuddApp.swift
//  BetBudd
//
//  Created by MacBook AIR on 07/10/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging
@main
struct BetBuddApp: App {
    @StateObject private var bettingDataModel = BettingSaveManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
       ContentView()
                .environmentObject(bettingDataModel)
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge,.sound,.alert]) { sucess, _ in
            guard sucess else {return}
            print("Sucess in Apns Redistry")
        }
        application.registerForRemoteNotifications()
     
        return true
    }
    
    //listen user
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, for completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
 
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, error in
            print(error?.localizedDescription)
            guard let token = token else {return}
            print("token\(token)")
        }
    }
   
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registered for Apple Remote Notifications")
       // print(deviceToken.hexString)
        
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

}

