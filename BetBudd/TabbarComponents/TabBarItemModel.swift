//
//  TabBarItemModel.swift
//  BetBudd
//
//  Created by MacBook AIR on 07/10/2023.
//

import Foundation
import SwiftUI

enum TabBarItem:Hashable {
    case homes,favorites,profile,settings
    var iconName:String {
        switch self{
        case .homes:
            return "gamecontroller.fill"
        case .favorites:
            return "list.clipboard"
        case .profile:
            return "chart.xyaxis.line"
        case .settings:
            return "gear"
        }
    }
    
    var title:String {
        switch self{
        case .homes:
            return "Home"
        case .favorites:
            return "Detail"
        case .profile:
            return "Chart"
        case .settings:
            return "Settings"
        }
        
    }
    
    
    var color:Color {
        switch self{
        case .homes:
            return Color.red
        case .favorites:
            return Color.blue
        case .profile:
            return Color.green
        case.settings:
            return Color.purple
        }
        
        
        
    }
    
}
