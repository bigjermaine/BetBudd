//
//  TipModel.swift
//  BetBudd
//
//  Created by MacBook AIR on 21/11/2023.
//

import Foundation
import CloudKit
struct Tips:Hashable {
var FirstPlayer:String
var SecondPlayer:String
var WinOrLoseImage:String
var WinSelection:String
var MoreTips:String
var gameImage:String
var percentageWin:String
var SecondPlayerpercentageWin:String
let record:CKRecord
}

