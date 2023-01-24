//
//  SaveProductModel.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 24/01/2023.
//

import Foundation

class SaveProductModel{
    
    var barcode: String = ""
    var theDesc: String = ""
    var id: String = ""
    var imageURL: String = ""
    var name: String = ""
    var retailPrice: Int = 0
    var costPrice: Int = 0
    var quantity: Int = 0
    
    init(){}
    
    init(product: ProductData){
        self.name = product.name ?? ""
        self.theDesc = product.descrpiation ?? ""
        self.imageURL = product.imageURL ?? ""
        self.id = product.id ?? ""
        self.barcode = product.barcode ?? ""
        self.retailPrice = Int(product.retailPrice)
        self.costPrice = Int(product.costPrice)
    }
    init(product: ProductValue){
        self.name = product.name
        self.theDesc = product.description
        self.imageURL = product.imageURL
        self.id = product.id
        self.barcode = product.barcode
        self.retailPrice = Int(product.retailPrice)
        self.costPrice = Int(product.costPrice ?? 0)
    }
}
