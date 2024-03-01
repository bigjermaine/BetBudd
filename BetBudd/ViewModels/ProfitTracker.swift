//
//  ProfitTracker.swift
//  BetBudd
//
//  Created by MacBook AIR on 08/11/2023.
//

import Foundation
import Combine


class ProfitTracker:ObservableObject {
    @Published    var numberOfDays:String = ""
    @Published    var numberOfOdds:String = ""
    @Published    var amountStake:String = ""
    @Published    var selectedSortOption:  ProfitCalculatorCase = .rollover
    @Published    var profitDisplay:Double = 0.0
    
    
    
    func calculateResult()  {
        if selectedSortOption == .rollover {
            if let amountStake = Double(amountStake),
               let numberOfOdds = Double(numberOfOdds),
               let numberOfDays = Double(numberOfDays) {
                
                let x = amountStake * pow(numberOfOdds, numberOfDays)
                profitDisplay = x
            } else {
                // Handle if any of the conversions fail
                // You might want to show an error message or take some other action
            }
        } else {
            calculateNonRollover()
        }
    }


    
    func calculateNonRollover() {
        let y =  Int(numberOfDays)  ?? 0
        let z = Int(numberOfOdds)  ?? 0
        let w = Int( amountStake) ?? 0
        let x =  y * z * w
       profitDisplay =  Double(x)
    }
    
    
}
