//
//  ViewModels.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/11/2023.
//

import Foundation
import CoreData

class BettingSaveManager:ObservableObject {
    
    
    let container:NSPersistentContainer
    @Published var bettingEntities:[UserDataEntity] = []
    
    init() {
        container = NSPersistentContainer(name:"CoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        fectchBettingData()
    }
    
    func sortBettingEntitiesByDateCreated(dataFetch:BettingDataFetch) {
        switch dataFetch{
        case .earlyDate:
            bettingEntities = bettingEntities.sorted { $0.theDate ?? Date() > $1.theDate ??  Date() }
        case .lateDate:
            bettingEntities = bettingEntities.sorted { $0.theDate ?? Date() < $1.theDate ??  Date() }
        case .highestAmount:
            bettingEntities = bettingEntities.sorted { $0.amount ?? "" >  $1.amount ??  "" }
        case .lowestAmount:
            bettingEntities = bettingEntities.sorted { $0.amount ?? "" < $1.amount ??  "" }
        }
       
    }
    
    func fectchBettingData() {
        let request = NSFetchRequest<UserDataEntity>(entityName: BettingCoreData)
        do {
            bettingEntities =  try container.viewContext.fetch(request)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addData(bettingData:UserData2) {
        
        let newData = UserDataEntity(context: container.viewContext)
        newData.amount = bettingData.amount
        newData.merchant = bettingData.merchant
        newData.theDate = bettingData.date
        saveData()
     
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
            fectchBettingData()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteFruit(indexSet:IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = bettingEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    
   
}


struct UserData2 {
    var merchant:String
    var amount:String
    var date:Date
}
