//
//  admin.swift
//  BetBudd
//
//  Created by MacBook AIR on 12/01/2024.
//

import Foundation

class AdminViewModel:ObservableObject {
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var error:Bool = false
    @Published var showScreen:Bool = false
    
    func login(){
        
    }
}


