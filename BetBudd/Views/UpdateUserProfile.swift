//
//  UpdateUserProfile.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/11/2023.
//

import Foundation

import SwiftUI

struct UpdateUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage( UserName) var userName =  UserName
    @AppStorage(Twitter) var twitterHandle = "@TwitterHandle"
    @AppStorage(Email) var eMailAdress = "user@domain.com"
    @AppStorage(YearlyBudget ) var yearlyBudget = 0.0
    
    @State private var newUserName = ""
    @State private var newTwitterHandle = ""
    @State private var newEMail = ""
    @State private var newYearlyBudget = ""
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Update user information:").font(.title2)
                HStack {
                    TextField("Username", text: $newUserName).textFieldStyle(.roundedBorder)
                    Button("Save") {
                        if newUserName.isEmpty == false {
                            userName = newUserName
                            newUserName = ""
                        }
                    }.buttonStyle(.bordered)
                }
                HStack {
                    TextField("Twitter", text: $newTwitterHandle).textFieldStyle(.roundedBorder)
                    Button("Save") {
                        if newTwitterHandle.isEmpty == false {
                            twitterHandle = newTwitterHandle
                            newTwitterHandle = ""
                        }
                    }.buttonStyle(.bordered)
                }
                HStack {
                    TextField("E-Mail", text: $newEMail).textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                    Button("Save") {
                        if newEMail.isEmpty == false {
                            eMailAdress = newEMail
                            newEMail = ""
                        }
                    }.buttonStyle(.bordered)
                }
                HStack {
                    TextField("Yearly budget", text: $newYearlyBudget).textFieldStyle(.roundedBorder).keyboardType(.numberPad)
                    Button("Save") {
                        if newYearlyBudget.isEmpty == false {
                            yearlyBudget = newYearlyBudget.toDouble() ?? 0.0
                            newYearlyBudget = ""
                        }
                    }.buttonStyle(.bordered)
                }
                Spacer()
                Text("(Tap the save button to update or save your user information").font(.footnote)
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .padding()
        
        }
        .overlay(starOverlay, alignment: .topLeading)
        .padding()
      
    }
    private var starOverlay: some View {
        Button{
            self.dismiss()
        }label: {
            
            
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
                .padding([.top, .trailing], 5)
        }
    }
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
      }
}

struct UpdateUserView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserView()
    }
}
