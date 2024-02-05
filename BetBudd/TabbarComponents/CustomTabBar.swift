//
//  CustomTabBar.swift
//  BetBudd
//
//  Created by MacBook AIR on 07/10/2023.
//

import SwiftUI

struct CustomTabBar: View {
    let tabs:[TabBarItem]
    @Binding var seletion:TabBarItem
    @Namespace var namespace
    @State var localSelection:TabBarItem
    var body: some View {
        HStack{
            ForEach(tabs,id:\.self) { tab in
              tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges:.bottom))
        .cornerRadius(10)
        .shadow(color: Color.black, radius: 10)
        .padding()
        .onChange(of: seletion) { newValue in
            withAnimation(.easeInOut) {
                localSelection = seletion
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static let tabs:[TabBarItem] = [
        .profile,.favorites,.homes
    ]
    
    
    
    
    static var previews: some View {
        VStack{
            Spacer()
            CustomTabBar(tabs: tabs, seletion: .constant(.homes), localSelection: .homes)
        }
    }
}


extension CustomTabBar {
    
    private func tabView(tab:TabBarItem) -> some View {
        VStack {
            Image(systemName:tab.iconName)
                .font(.subheadline)
                .foregroundColor(.black)
            Text(tab.title)
                .foregroundColor(.black)
                .font(.system(size: 10,weight: .semibold,design: .rounded))
        }
        .foregroundColor(localSelection  == tab ? tab.color : Color.gray)
        .padding(.vertical,8)
        .frame(maxWidth:.infinity)
        .background(
            ZStack{
                if localSelection  == tab {
                    RoundedRectangle(cornerRadius:10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle",in: namespace)
                }
                
            }
        )
        
    }
    private func switchToTab(tab:TabBarItem) {
       
            seletion = tab
        
    }
}

