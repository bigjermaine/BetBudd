//
//  NotificationManager.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/11/2023.
//

import Foundation
import UserNotifications
import CloudKit
import UIKit


//Notification Manager
class  NotificationManager {
    
    static let instance = NotificationManager()
    var notificationBody:String?
    var totalMessages:[String] = []
    
    init() {
        extract()
        totalMessages =  MessagesDataManager.shared.totalMessagesData()
        notificationBody = MessagesDataManager.shared.totalMessagesData()[getStoredNumber()]
      
    }
    
    
    func requestauthoriztion() {
        
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { ( success
                                                                                      , error) in
            if let error = error {
                print("Error:\(error)")
            }else {
                self.scheduleNotifications()
                print("sucess")
            }
        }
    }
    
    func cancelnotificatios() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
    }
    func scheduleNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Motivational Reminder"
        content.sound = .default
        content.badge = 1
        
        let calendar = Calendar.current
        let now = Date()
      
        // Get the next message
        content.body = notificationBody ?? ""
       
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 59
        dateComponents.day = calendar.component(.day, from: now)
        if let nextDate = calendar.date(from: dateComponents) {
            let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: nextDate), repeats: true)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled: \(request)")
                }
            }
        
         
        }
    }

    func extract() {
        let currentDate = Date()
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        
            if let currentDay = Int(dayFormatter.string(from: currentDate)) {
            
            var storedNumber = UserDefaults.standard.integer(forKey: "dailyNumber")
        
            if currentDay != UserDefaults.standard.integer(forKey: "lastStoredDay") {
                if totalMessages.count <= storedNumber {
                    storedNumber += 1
                    UserDefaults.standard.set(currentDay, forKey: "lastStoredDay")
                    UserDefaults.standard.set(storedNumber, forKey: "dailyNumber")
                }
             
            }
           } else {
            print("Error extracting the current day.")
        }
     }
    
    func getStoredNumber() -> Int {
        let storedNumber = UserDefaults.standard.integer(forKey: "dailyNumber")
        print(storedNumber)
        return storedNumber
     }
    
    
    func requestauthoriztionCloud() {
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { ( success
                                                                                      , error) in
            if let error = error {
                print("Error:\(error)")
            }else {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    self.subcriptionNotifcations()
                }
             
                print("sucess")
            }
        }
    }
    
    func subcriptionNotifcations() {
        let predicate = NSPredicate(value: true)
        let subcriptions = CKQuerySubscription(recordType: "TipsAlert", predicate: predicate,subscriptionID: "fruit_added_to_database",options: .firesOnRecordCreation)
        let notifcation = CKSubscription.NotificationInfo()
        notifcation.title = "New Tips Added"
        notifcation.alertBody = "Good luck with your selection"
        notifcation.soundName = "default"
        subcriptions.notificationInfo = notifcation
        CKContainer.default().publicCloudDatabase.save(subcriptions) { subcription, error in
            if let error =  error {
                print(error)
            }else{
                print("sucessfullly")
            }
        }
        
        
    }
    
}
