//
//  TipsViewModel.swift
//  BetBudd
//
//  Created by MacBook AIR on 22/11/2023.
//

import Foundation
import CloudKit
import SwiftUI

class CloudKitViewModel: ObservableObject {
    
    @Published var isSigned:Bool = false
    @Published var error:String = ""
    @Published var name:String = ""
    @Published var name2:String = ""
    @Published var tip:String = ""
    @Published var percentage:String = "0.0"
    @Published var percentage2:String = "0.0"
    @Published var moreTip:String = ""
    @Published var image    :String = ""
    @Published var winLoseimage    :String = ""
    @Published var returnedStatus:Bool = false
    @Published var Tips:[Tips] = []
    @Published var error2:Bool = false
    @Published var isLoading:Bool = false
    init() {
        getCloudStatus()
        requestForPermission()
        fetchItems()
    
    }
    
    func unsubcripNotifcation() {
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "fruit_added_to_database")
        { subcription, error in
            if let error =  error {
                print(error)
            }else{
                print("sucessfullly")
            }
        }
    }
        
    
    func addItem() {
        if name.isEmpty || name2.isEmpty || tip.isEmpty || moreTip.isEmpty || image.isEmpty || winLoseimage.isEmpty {
               // Handle the case where any of these variables is an empty string
             error2 = true
               return
           }
        let newfruit = CKRecord(recordType: "Tips")
        newfruit["name"] = name
        newfruit["name2"] = name2
        newfruit["tip"] = tip
        newfruit["moreTip"] = moreTip
        newfruit["image"] = image
        newfruit["winImage"] = winLoseimage
        newfruit["percent"] = percentage
        newfruit["percent2"] = percentage2
       
        saveItems(ck: newfruit)
        DispatchQueue.main.async {[weak self] in
            self?.fetchItems()
            self?.name = ""
            self?.name2 = ""
            self?.tip = ""
            self?.moreTip = ""
            self?.image = ""
            self?.winLoseimage = ""
            self?.percentage = ""
            self?.percentage2 = ""
        }
        
    }
    func addItem2() {
        let newfruit = CKRecord(recordType: "TipsAlert")
        newfruit["name"] = name
        saveItems(ck: newfruit)
        DispatchQueue.main.async {[weak self] in
            self?.name = ""
            
        }
        
    }
    
    private func saveItems(ck:CKRecord) {
        CKContainer.default().publicCloudDatabase.save(ck) {[weak self] returnRecord, returnError in
            DispatchQueue.main.async {
                self?.name = ""
            }
           
        }
    }
    
    private func getCloudStatus() {
        CKContainer.default().accountStatus {[weak self ] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .couldNotDetermine:
                    self?.error = CloudKitError.icldAccountNotDetermined.localizedDescription
                case .available:
                    self?.isSigned = true
                case .restricted:
                    self?.error = CloudKitError.icloudAccountRestricted .localizedDescription
                case .noAccount:
                    self?.error = CloudKitError.iCloudNotFound.localizedDescription
                case .temporarilyUnavailable:
                    self?.error = CloudKitError.icloudAccountUnknown.localizedDescription
                @unknown default:
                  print("error")
                }
            }
        }
    }
    
    func requestForPermission(){
        CKContainer.default().requestApplicationPermission(.userDiscoverability) {[weak self] returnedStatus, error in
            if returnedStatus == .granted {
                DispatchQueue.main.async {
                    self?.returnedStatus = true
                }
             
                self?.getUserId()
            }
            print(error?.localizedDescription)
        }
    }
    
    func getUserId(){
        CKContainer.default().fetchUserRecordID {[weak self] id, error in
            if let id = id {
                self?.discoverIcloudUser(id:id)
            }
            
        }
    }
    
    func discoverIcloudUser(id:CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, error in
            if let name = returnedIdentity?.nameComponents?.givenName {
                DispatchQueue.main.async {
                    self?.name = name
                }
            }
            
        }
        
    }
    func fetchItems() {
        isLoading = true
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Tips", predicate:  predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let queryOperation = CKQueryOperation(query: query)
        var returnedItems:[Tips] = []
        if #available(iOS 15, *) {
            queryOperation.recordMatchedBlock = { (returnedID,returnedResult) in
                switch returnedResult {
                    
                case .success(let record):
                    guard let name = record["name"] as? String,
                          let name2 = record["name2"] as? String,
                          let tip = record["tip"] as? String,
                          let moreTip = record["moreTip"] as? String,
                          let winImage =  record["winImage"] as? String,
                          let percent = record["percent"] as? String,
                          let percent2 = record["percent2"] as? String,
                          let imageTip = record["image"] as? String else {
                        return
                    }

                    DispatchQueue.main.async {
                        let fruitModel = BetBudd.Tips(FirstPlayer: name, SecondPlayer: name2, WinOrLoseImage: winImage, WinSelection: tip, MoreTips: moreTip, gameImage: imageTip, percentageWin:  percent, SecondPlayerpercentageWin: percent2, record: record)
                        returnedItems.append(fruitModel)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
            
        }else {
            queryOperation.recordFetchedBlock = {(returnedRecord) in
                guard let name = returnedRecord["name"] as? String else {return}
                DispatchQueue.main.async {
                   // FruitModel(name: <#T##String#>, record: <#T##CKRecord#>)
                    //returnedItems.append()
                }
                
            }
        }
        if #available(iOS 15, *) {
            queryOperation.queryResultBlock = {[weak self] returnedResult in
                print(returnedResult)
                DispatchQueue.main.async {
                    self?.Tips = returnedItems
                    self?.isLoading = false
                }
               
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self](returnedCursor, returnedError) in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.Tips = returnedItems
                }
            }
        }
        addOprations(operation: queryOperation)
    }
    
    
    func addOprations(operation:CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    
    enum CloudKitError:LocalizedError{
        case iCloudNotFound
        case icldAccountNotDetermined
        case icloudAccountRestricted
        case icloudAccountUnknown
    }
    
    func updateLose(Fruit:Tips){
        Tips = []
        let record = Fruit.record
        record["winImage"] = "L"
        saveItems(ck: record)
        fetchItems()
    }
    
    func updateWin(Fruit:Tips){
        Tips = []
        let record = Fruit.record
        record["winImage"] = "W"
        saveItems(ck: record)
        fetchItems()
    }
    
    func Delete(Fruit:IndexSet){
        guard let index = Fruit.first else {return}
        let fruit = Tips[index]
        let record = fruit.record
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) {[weak self]  returnedRecord, returnedError in
            print(returnedError?.localizedDescription)
            DispatchQueue.main.async {
                self?.Tips.remove(at: index)
            }
           
        }
    }
}
