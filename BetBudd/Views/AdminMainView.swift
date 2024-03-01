//
//  AdminMainView.swift
//  BetBudd
//
//  Created by MacBook AIR on 23/11/2023.
//

import SwiftUI

struct AdminMainView: View {
    @StateObject private var vm = CloudKitViewModel()
  
    var body: some View {
        TabView {
            DeleteList()
                .environmentObject(vm)
                .tabItem {
                    Label("Home", systemImage: "gamecontroller.fill")
                }
              
             PredicationEntryView()
                .environmentObject(vm)
                .tabItem {
                    Label("Transactions", systemImage: "chart.xyaxis.line")
                }
        }
    }
}

struct AdminMainView_Previews: PreviewProvider {
    static var previews: some View {
        AdminMainView()
    }
}
