//
//  TabbarItemsKey.swift
//  BetBudd
//
//  Created by MacBook AIR on 07/10/2023.
//

import Foundation
import SwiftUI


struct TabBarItemPrefernceKey:PreferenceKey {
    
     static var defaultValue: [TabBarItem] = []
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
    
}



struct TabBarItemViewModifier:ViewModifier {
    let tab:TabBarItem
    @Binding var selection:TabBarItem
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemPrefernceKey.self,value:[tab])
        
    }
}

extension View {
    
    func tab(tab:TabBarItem,selection:Binding<TabBarItem>) -> some View {
        self.modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
    
}
