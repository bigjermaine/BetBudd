//
//  MainTabbar.swift
//  BetBudd
//
//  Created by MacBook AIR on 07/10/2023.
//

import SwiftUI

struct MainTabbar: View {
    @State private var tabSelection:TabBarItem =  .homes
    @StateObject private var bettingDataModel = BettingSaveManager()
    var body: some View {
        TabView {
            
            EntryView()
                .environmentObject(bettingDataModel)
                .tabItem {
                    Label("Home", systemImage: "gamecontroller.fill")
                       
                        
                     
                }
               
                .onTapGesture {
                    hideKeyboard()
                }
            TransactionDetailsView()
                .environmentObject(bettingDataModel)
                .tabItem {
                    Label("Transactions", systemImage: "chart.xyaxis.line")
                }
            
            Predication()
                .tabItem {
                    Label("Predictions", systemImage: "tennisball")
                }
           
            OldProfitCalculator()
                .tabItem {
                    Label("Profit Checker", systemImage: "brain.head.profile")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .environmentObject(bettingDataModel)
            
         
        
                  
        }
        .onAppear{
            NotificationManager.instance.extract()
            NotificationManager.instance.requestauthoriztionCloud()
            HapticManager.shared.vibrateForSelection()
         }
        
    }
       
}

struct MainTabbar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbar()
    }
}
