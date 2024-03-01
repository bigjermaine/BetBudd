//
//  OldProfitCalculator.swift
//  BetBudd
//
//  Created by MacBook AIR on 08/11/2023.
//

import SwiftUI
import Combine
struct OldProfitCalculator: View {
   
    @StateObject var profitTracker = ProfitTracker()
    @FocusState private var nameIsFocused: Bool
    @State var number:String = ""
    @State private var isKeyboardVisible = false
    var body: some View {
        
        ZStack {
            VStack{
                VStack(spacing:20){
                    HStack{
                        
                        Picker("Sort By", selection: $profitTracker.selectedSortOption) {
                            Text("Rollover").tag(ProfitCalculatorCase.rollover)
                            Text("Non-Rollover").tag(ProfitCalculatorCase.nonRollover)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of:profitTracker.selectedSortOption) { _ in
                            profitTracker.calculateResult()
                        }
                    }
                    .frame(height:40)
                    
                    Text(String(profitTracker.profitDisplay))
                        .font(.largeTitle)
                    VStack(alignment:.leading){
                        Text("Amount")
                            .font(.caption)
                        HStack {
                            Image(systemName: "gamecontroller.fill")
                                .font(.system(size: 25))
                                .padding()
                            TextField("Amount", text:  $profitTracker.amountStake)
                                .keyboardType(.decimalPad)
                            
                        }
                        .modifier(TextfieldModifier())
                        Text("range")
                            .font(.caption)
                        HStack {
                            Image(systemName: "o.circle.fill")
                                .font(.system(size: 25))
                                .padding()
                            TextField("Number Of Odds", text: $profitTracker.numberOfOdds)
                                .keyboardType(.decimalPad)
                        }
                        .modifier(TextfieldModifier())
                        Text("days")
                            .font(.caption)
                        HStack {
                            Image(systemName: "checkerboard.rectangle")
                                .font(.system(size: 25))
                                .padding()
                            TextField("Number Of Days", text: $profitTracker.numberOfDays)
                                .keyboardType(.decimalPad)
                        }
                        .modifier(TextfieldModifier())
                    }
                    .onTapGesture {
                        nameIsFocused = false
                        hideKeyboard()
                    }
                    
                    
                }
                .padding()
                Spacer()
                VStack {
                    AdBannerView(adUnitID: "ca-app-pub-4916382790527707/1575139226") // Replace with your ad unit ID
                        .frame(height: 50)
                    
                       }
                    .onChange(of:profitTracker.numberOfDays) { _ in
                        profitTracker.calculateResult()
                    }
                    .onAppear {
                        HapticManager.shared.vibrateForSelection()
                       
                    }
                
            }
        }
     }
    
}

struct OldProfitCalculator_Previews: PreviewProvider {
    static var previews: some View {
        OldProfitCalculator()
    }
}
