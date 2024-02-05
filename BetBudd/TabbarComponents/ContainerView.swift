//
//  ContainerView.swift
//  BetBudd
//
//  Created by MacBook AIR on 07/10/2023.
//

import SwiftUI


struct ContainerView<Content:View>: View {
    @Binding var selection:TabBarItem
    let  content:Content
    @State private var tabs:[TabBarItem] = []
    public init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content){
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment:.bottom){
                content
                .ignoresSafeArea()
            CustomTabBar(tabs: tabs, seletion: $selection, localSelection: selection)
            }
            .onPreferenceChange(TabBarItemPrefernceKey.self,perform: { value in
                self.tabs = value
            })
        }
    }

struct ContainerView_Previews: PreviewProvider {
    static let tabs:[TabBarItem] = [
        .profile,.favorites,.homes
    ]
    
    
    
    static var previews: some View {
        ContainerView(selection: .constant(.homes)) {
            Color.red
        }
    }
}
