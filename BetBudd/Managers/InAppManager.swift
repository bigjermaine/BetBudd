//
//  InAppManager.swift
//  BetBudd
//
//  Created by MacBook AIR on 06/11/2023.
//
import StoreKit
import Foundation

class InAppManager:NSObject, SKProductsRequestDelegate,SKPaymentTransactionObserver,ObservableObject {
    @Published  var producePrice:String?
    @Published var myProduct:SKProduct?
    @Published var checkpurchase:Bool?
    override init() {
        super.init()
    
        checkPurchse()
        self.fetchProducts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.fetchPriceLocal()
        }
            
        
    }
    
    func checkPurchse() {
        checkpurchase = UserDefaults.standard.bool(forKey: "Coffee")
    }

    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: ["Coffee"])
        request.delegate = self
        request.start()
    }
    
    
    func fetchPriceLocal() {
        if let myProduct = myProduct {
            let priceFormatter = NumberFormatter()
            priceFormatter.numberStyle = .currency
            priceFormatter.locale = myProduct.priceLocale

            if let formattedPrice = priceFormatter.string(from: myProduct.price) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.producePrice = formattedPrice
                }
            }
        }
    }
    func didTapBuy() {
        guard let myProduct = myProduct else {return}
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: myProduct)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            print(product.localizedDescription)
            print(product.price)
            print(product.productIdentifier)
            print(product.localizedDescription)
            DispatchQueue.main.async {
                self.myProduct = product
            }
           
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState{
            case .purchasing:
                UserDefaults.standard.set(true, forKey: "Coffee")
                checkPurchse()
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            case .restored:
                UserDefaults.standard.set(true, forKey: "Coffee")
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            case .deferred:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            @unknown default:
                print("")
            }
        }
    }
    
}
