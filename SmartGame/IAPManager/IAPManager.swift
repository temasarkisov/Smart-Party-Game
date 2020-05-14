//
//  IAPManager.swift
//  SmartGame
//
//  Created by Paw.toporkov on 22/03/2020.
//  Copyright © 2020 TemaPasha. All rights reserved.
//

import Foundation
import StoreKit

class IAPManager: NSObject {
    
    static let productNotificationIdentifier = "IAPManagerProductIdentifier"
    static let shared = IAPManager()
    private override init() {}
    
    var products: [SKProduct] = []
    let paymentQueue = SKPaymentQueue.default()
    var productsRequest = SKProductsRequest()
    
    
    
    public func setupPurchases(callback: @escaping(Bool) -> ()) {
        // если устройство может выполнять платеж
        if SKPaymentQueue.canMakePayments() {
            SKPaymentQueue.default().add(self) // добавляем наблюдателя за транзакцией
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts() {
        // при входе в программу запрашиваем товары по id
        let identifiers: Set = [ // <- множество id
            IAPProducts.Geography_ru.rawValue,
            IAPProducts.Food_ru.rawValue,
            IAPProducts.History_ru.rawValue,
            IAPProducts.Technologys_ru.rawValue,
            IAPProducts.Art_ru.rawValue,
            IAPProducts.HumanitarianMix_ru.rawValue,
            IAPProducts.Sport_ru.rawValue,
            IAPProducts.Math_ru.rawValue,
            IAPProducts.Movies_ru.rawValue,
            IAPProducts.Books_ru.rawValue,
            IAPProducts.Jobs_ru.rawValue,
            IAPProducts.Patry_ru.rawValue,
            IAPProducts.Clothes_ru.rawValue,
            IAPProducts.Kids_ru.rawValue
        ]
        
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self // <- делегат, показывающий, что мы хотим получить ответ на запрос
        productRequest.start() // <- запускаем запрос
    }
    
    public func purchase(productWith identifier: String) {
        guard let product = products.filter({ $0.productIdentifier == identifier }).first else { return }
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
    
    
    public func restoreCompleteTransaction() {
        paymentQueue.restoreCompletedTransactions()
    }
    
    
}

extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .deferred: break
            case .purchasing: break
            case .failed: failed(transaction: transaction)
            case .purchased: completed(transaction: transaction)
            case .restored: restored(transaction: transaction)
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
    }
    
    private func failed(transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError? {
            if transactionError.code != SKError.paymentCancelled.rawValue {
                print("Ошибка транзакции: \(transaction.error!.localizedDescription)")
            }
        }
        paymentQueue.finishTransaction(transaction)
    }
    
    private func completed(transaction: SKPaymentTransaction) {
        NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
        paymentQueue.finishTransaction(transaction)
    }
    
    private func restored(transaction: SKPaymentTransaction) {
        paymentQueue.finishTransaction(transaction)
    }
}

extension IAPManager: SKProductsRequestDelegate {
    // получаем ответ на запрос
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        print(products)
        products.forEach { print($0.localizedTitle) } // <- информация о каждом товаре
        if products.count > 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: IAPManager.productNotificationIdentifier), object: nil)
        }
    }
}
