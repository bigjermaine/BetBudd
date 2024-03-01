//
//  PasswordView.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/11/2023.
//

import Foundation

import SwiftUI



struct PasswordView: View {
    
    @AppStorage("ThePassword") var thePassword = "---"
    @State private var randomPasswordArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    @State private var hiddenPassword = "********************"
    
    @AppStorage("HidePasswordUntil") var hideUntilDate = Date()
    
    @State private var hideDate = Date()
    
    var body: some View {
        VStack {
            Text("Random password:").font(.title2)
            Divider()
            if hideUntilDate > Date() {
                Text(hiddenPassword).font(.title3).padding(.vertical, 5)
            }
            else {
                Text(thePassword).font(.title3).padding(.vertical, 5)
            }
            Divider()
            if hideUntilDate > Date() {
                Text("Password is hidden until:")
                Text("\((hideUntilDate).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).year().hour().minute()))")
                Divider()
                Button() {
                    copyPassword()
                } label: {
                    Text("Copy")
                    Image(systemName: "doc.on.doc")
                }.font(.title2).buttonStyle(.bordered)
            } else {
                Text("Hide password until:")
                DatePicker("Hide password until:", selection: $hideDate).labelsHidden()
                Divider()
                Button("Generate", action: {generatePassword()}).font(.title2).buttonStyle(.bordered)
            }
        }
    }
    func generatePassword() {
        if thePassword != "" {
            thePassword = ""
        }
        randomPasswordArray.shuffle()
        for _ in 1...20 {
            thePassword.append(randomPasswordArray[Int.random(in: 0...randomPasswordArray.count-1)])
        }
        hideUntilDate = hideDate
    }
    func copyPassword() {
        UIPasteboard.general.string = thePassword
    }
}

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}
