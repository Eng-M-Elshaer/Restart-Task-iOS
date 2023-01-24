//
//  SavedProductsManager.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import CoreData

class SavedProductsManager{
    
    // MARK: - Properties
    private var products = [SaveProductModel]()
    private var saveProductRepo: CoreDataRepository<ProductData>?
    
    // MARK: - Init
    init(savePlaceRepo: CoreDataRepository<ProductData>? = nil) {
        self.saveProductRepo = savePlaceRepo ?? CoreDataRepository<ProductData>()
    }
    
    // MARK: - Public Methods
    public func getSavedProducts() -> [SaveProductModel] {
        products.removeAll()
        let products = saveProductRepo?.getAll()
        for item in products ?? [] {
            let product = SaveProductModel()
            product.id = item.id ?? ""
            product.name = item.name ?? ""
            product.theDesc = item.descrpiation ?? ""
            product.imageURL = item.imageURL ?? ""
            product.barcode = item.barcode ?? ""
            product.retailPrice = Int(item.retailPrice)
            product.costPrice = Int(item.costPrice)
            product.quantity = Int(item.quantity)
            self.products.append(product)
        }
        return self.products
    }
    public func clearCoreData(){
        saveProductRepo?.deleteAll()
    }
    public func getProductsCount() -> Int{
        if let count = saveProductRepo?.getCount(){
            print("Saved Entities Count: ", count)
            return count
        }
        return 0
    }
    public func checkQuantity(_ product: ProductValue?) {
        var isNew: Bool = true
        if getProductsCount() == 0 {
            addNewProduct(product)
        } else {
            let products = saveProductRepo?.getAll()
            for item in products ?? [] {
                if item.id == product?.id {
                    update(with: item.id!)
                    isNew = false
                    break
                }
            }
            if isNew {
                addNewProduct(product)
            }
        }
    }
    public func getQuantityCount(with id: String) -> Int{
        let products = saveProductRepo?.getAll()
        for item in products ?? []{
            if item.id == id {
                return Int(item.quantity)
            }
        }
        return 0
    }
    public func update(with id: String, add: Bool = true) {
        let products = saveProductRepo?.getAll()
        for item in products ?? []{
            if item.id == id {
                if add {
                    item.quantity += 1
                } else {
                    item.quantity -= 1
                }
            }
        }
        try? saveProductRepo?.context?.save()
    }
    public func delete(with id: String) {
        let products = saveProductRepo?.getAll()
        for item in products ?? []{
            if item.id == id {
                saveProductRepo?.context?.delete(item)
            }
        }
    }
    public func addNewProduct(_ product: ProductValue?) {
        if let context = saveProductRepo?.context {
            let saveProductModel = ProductData.init(context: context)
            saveProductModel.id = product?.id
            saveProductModel.quantity = 1
            saveProductModel.name = product?.name
            saveProductModel.descrpiation = product?.description
            saveProductModel.imageURL = product?.imageURL
            saveProductModel.barcode = product?.barcode
            saveProductModel.costPrice = Int64(product?.costPrice ?? 0)
            saveProductModel.retailPrice = Int64(product?.retailPrice ?? 0)
            saveProductRepo?.register(value: saveProductModel)
        }
    }
}
