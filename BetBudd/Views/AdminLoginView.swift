//
//  AdminLoginView.swift
//  BetBudd
//
//  Created by MacBook AIR on 11/01/2024.
//

import SwiftUI
struct AdminLoginView: View {
    @StateObject var adminViewModel = AdminViewModel()
  
    var body: some View {
        VStack{
            Text("Login")
                .italic()
                .font(.largeTitle)
            Spacer()
            VStack(spacing:30){
                HStack {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 25))
                        .padding()
                    TextField("Email", text: $adminViewModel.email)
                    
                }
                .modifier(TextfieldModifier())
                HStack {
                    Image(systemName: "key.fill")
                        .font(.system(size: 22))
                        .padding()
                    TextField("Password", text: $adminViewModel.password)
                    
                }
                .modifier(TextfieldModifier())
                Button{
                    adminViewModel.login()
                }label: {
                    Text("Login")
                }
                
                .alert("Error Signing", isPresented:$adminViewModel.error, actions: {
                })
                .fullScreenCover( isPresented: $adminViewModel.showScreen) {
                    AdminMainView()
                }
            }
            .padding()
            Spacer()
        }
    }
}
//#Preview {
//    AdminLoginView()
//}
