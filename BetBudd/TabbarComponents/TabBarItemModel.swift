//
//  TabBarItemModel.swift
//  BetBudd
//
//  Created by MacBook AIR on 07/10/2023.
//

import Foundation
import SwiftUI

enum TabBarItem:Hashable {
    case homes,favorites,profile,settings,tips
    var iconName:String {
        switch self{
        case .homes:
            return "gamecontroller.fill"
        case .favorites:
            return "brain.head.profile"
        case .profile:
            return "chart.xyaxis.line"
        case .settings:
            return "gear"
        case .tips:
            return "bitcoinsign.circle.fill"
        }
    }
    
    var title:String {
        switch self{
        case .homes:
            return "Home"
        case .favorites:
            return "Profit Checker"
        case .profile:
            return "Chart"
        case .settings:
            return "Settings"
        case .tips:
            return  "Tips"
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
        case .tips:
            return  Color.green
        }
        
        
        
    }
    
}
