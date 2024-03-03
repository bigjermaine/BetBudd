//
//  ChartView.swift
//  BetBudd
//
//  Created by MacBook AIR on 03/03/2024.
//


import SwiftUI
import SwiftUICharts
import CoreData
struct ChartView: View {
  
    @EnvironmentObject var bettingViewModel:BettingSaveManager
    @State private var totalAmountSpent:  [Double] = []
    var demoData: [Double] = [8.00, 2.00, 4, 6, 12.00, 9.00, 2.00]
    var sum: Double = 0.00
    
    var body: some View {
        
        VStack{
            if  !totalAmountSpent.isEmpty {
                LineView(data: totalAmountSpent, title: "BettingExpenseChart")
                    .padding(.horizontal)
                Spacer()
                
                LineChartView(data: totalAmountSpent, title: "Exp")
            }else {
                VStack{
                    Text("Add some Transactions,to display graph")
                        .bold()
                        .fontWeight(.semibold)
                }
            }
            
        }
        .padding(.horizontal,8)
        .onAppear{
            addTotal()
        }
        
    }
    
    func addTotal() {
        for transaction in bettingViewModel.bettingEntities.map({$0.amount}) {
            let totalAmountSpent = transaction?.toDouble() ?? 0.00
            self.totalAmountSpent.append(totalAmountSpent)
        }
        
        
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
