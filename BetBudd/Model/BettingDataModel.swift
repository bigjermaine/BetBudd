//
//  BettingDataModel.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/11/2023.
//

import Foundation

enum BettingDataFetch {
    case earlyDate
    case lateDate
    case highestAmount
    case lowestAmount
}


enum ProfitCalculatorCase: Equatable {
    case rollover
    case nonRollover
    
    static func == (lhs: ProfitCalculatorCase, rhs: ProfitCalculatorCase) -> Bool {
        switch (lhs, rhs) {
        case (.rollover, .rollover), (.nonRollover, .nonRollover):
            return true
        default:
            return false
        }
    }
}
