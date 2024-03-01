//
//  TransactionDetailsView.swift
//  BetBudd
//
//  Created by MacBook AIR on 04/11/2023.
//

import SwiftUI

struct TransactionDetailsView: View {
    @State private var progressPercent = 0.0
    @State var animmate:Bool = false
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @State private var totalAmountSpent = 0.0
    @State private var amountToAdd = 0.0
    @AppStorage("YearlyBudget") var yearlyBudget = 0
    @State private var toogleYearlyView:Bool = false
    @EnvironmentObject var bettingViewModel:BettingSaveManager
    @State private var selectedSortOption: BettingDataFetch = .earlyDate
    @State var circleviewaniamtion:Bool = false
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                ZStack{
                    Circle()
                        .stroke(lineWidth:30)
                        .opacity(0.5)
                        .foregroundColor(.blue)
                    Circle()
                        .trim(from: 0.0, to: min(1.0, progressPercent))
                        .stroke(AngularGradient(gradient: Gradient(colors: [.red,.yellow,.blue]), center: .center),style:StrokeStyle(lineWidth:30))
                        .rotationEffect(Angle(degrees: 270))
                    VStack{
                        VStack{
                            Text("Yearly budget:")
                                .font(.footnote)
                            Text(("\(yearlyBudget)").currencyFormatting())
                                .font(.title3)
                                .scaleEffect(animmate ? 1.1:1.0)
                        }
                        VStack{
                            Text("Amount Spent:")
                                .font(.footnote)
                                .scaleEffect(animmate ? 1.1:1.0)
                            Text(("\(totalAmountSpent)").currencyFormatting())
                                .font(.title3)
                        }
                    }
                }
              
                .frame(width: screenWidth / 1.5, height: screenWidth / 2.2)
                .padding()
                .offset(y: circleviewaniamtion ? 0 :800)
                VStack {
                    Picker("Sort By", selection: $selectedSortOption) {
                        Text("Early Date").tag(BettingDataFetch.earlyDate)
                        Text("Late Date").tag(BettingDataFetch.lateDate)
                        Text("Highest").tag(BettingDataFetch.highestAmount)
                        Text("Lowest").tag(BettingDataFetch.lowestAmount)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedSortOption) { _ in
                        bettingViewModel.sortBettingEntitiesByDateCreated(dataFetch: selectedSortOption)
                    }
                }
                Divider()
                List {
                    ForEach(bettingViewModel.bettingEntities) { expenses in
                        VStack(alignment: .leading) {
                            HStack {
                                HStack{
                                    Text("\(expenses.merchant ?? "")")
                                    
                                }
                                .frame(maxWidth:.infinity,alignment:.leading)
                                Spacer()
                                
                                HStack{
                                    Text(("\(expenses.amount ?? "")").currencyFormatting())
                                        .foregroundColor(.green)
                                }
                                .frame(maxWidth:100,alignment:.leading)
                                
                            }
                            Text("\((expenses.theDate ?? Date()).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).year().hour().minute()))")
                                .font(.system(size: 14))
                                .font(.subheadline)
                                .foregroundColor(.brown)
                        }
                        
                    }
                    .onDelete(perform: bettingViewModel.deleteFruit)
                    .onChange(of:yearlyBudget) { _ in
                        addTotal()
                    }
                    
                }
                .onChange(of:bettingViewModel.bettingEntities) { _ in
                    addTotal()
                }
                
            }
            .navigationViewStyle(.stack)
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ChartView()
                            .environmentObject(bettingViewModel)
                    }label:{
                        Text("Chart")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        YearlyUpdate()
                            .environmentObject(bettingViewModel)
                    }label:{
                        Text("Add Yearly Target")
                            .font(.caption2)
                    }
                }
                
            }
            
            .onAppear {
                HapticManager.shared.vibrateForSelection()
                addTotal()
                UIApplication.shared.applicationIconBadgeNumber = 0
                addAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5 )) {
                        circleviewaniamtion = true
                    }
                }
            }
            
            
        }
        .navigationViewStyle(.stack)
        
    }
    func addAnimation() {
        guard !animmate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                animmate.toggle()
            }
        }
    }
    
    func addTotal() {
        totalAmountSpent = 0.0
        for transaction in bettingViewModel.bettingEntities {
            totalAmountSpent += transaction.amount?.toDouble() ?? 0.0
        }
        progressPercent = (totalAmountSpent / Double(yearlyBudget))
    }
}


struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView()
           
    }
}
