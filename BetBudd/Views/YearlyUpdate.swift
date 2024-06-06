//
//  YearlyUpdate.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/01/2024.
//

import SwiftUI

struct YearlyUpdate: View {
    @AppStorage(YearlyBudget ) var yearlyBudget = 0.0
    @State private var dataSavedPresented = false
    @State private var newYearlyBudget = ""
    var body: some View {
        VStack(alignment: .center){
            Text("Add Yearly Budget")
                .font(.largeTitle)
            HStack {
                TextField(String(yearlyBudget), text: $newYearlyBudget).textFieldStyle(.roundedBorder).keyboardType(.numberPad)
                Button("Save") {
                    if newYearlyBudget.isEmpty == false {
                        yearlyBudget = newYearlyBudget.toDouble() ?? 0.0
                        newYearlyBudget = ""
                        dataSavedPresented  = true
                    }
                }.buttonStyle(.bordered)
            }
        }
        .padding()
        .alert("Yearly Target Saved", isPresented: $dataSavedPresented, actions: {
        })
    }
}

//#Preview {
//    YearlyUpdate()
//}
