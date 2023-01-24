//
//  MainViewModel.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import Foundation

protocol MainViewModelProtocol {
    func getProducts() -> [SaveProductModel]
    func getTotalCostOfProducts() -> String
    func clearTheData()
    func getProductsCount() -> Int
    func deleteItem(product: SaveProductModel)
    func getLoclData()
}

class MainViewModel {
    
    // MARK: - Private Properties
    private weak var view: MainVCProtocol?
    private var products = [ProductValue]()
    private var savedProducts = [SaveProductModel]()
    private var savedProductsManager: SavedProductsManager = SavedProductsManager()
    
    // MARK: - Init
    init(view: MainVCProtocol) {
        self.view = view
    }
}

// MARK: - MainViewModelProtocol
extension MainViewModel: MainViewModelProtocol {
    internal func getProducts() -> [SaveProductModel] {
        return self.savedProducts
    }
    internal func getTotalCostOfProducts() -> String{
        return "\(getTotalCost())"
    }
    internal func clearTheData(){
        savedProductsManager.clearCoreData()
        savedProducts.removeAll()
        self.view?.setTotalCost(cost: "0")
        self.view?.reloadTable()
    }
    internal func getProductsCount() -> Int{
         return savedProductsManager.getProductsCount()
    }
    internal func deleteItem(product: SaveProductModel){
        if savedProductsManager.getQuantityCount(with: product.id) == 1 {
            savedProductsManager.delete(with: product.id)
        } else {
            savedProductsManager.update(with: product.id, add: false)
        }
        self.getDataFromCoreData()
    }
    internal func getLoclData(){
        if savedProductsManager.getProductsCount() > 0 {
            self.savedProducts = savedProductsManager.getSavedProducts()
            self.view?.setTotalCost(cost: getTotalCost())
            self.view?.reloadTable()
        } else {
            callProductsAPI()
        }
    }
}

// MARK: - APIs Calls
extension MainViewModel {
    private func callProductsAPI(){
        self.view?.showLoader()
        APIManager.getProducts { response, code in
            switch response {
            case .success(let result):
                guard let products = result else {return}
                self.addToProdctsArray(products)
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showAlert(with: AlertMessage.somethingWentWrong)
            }
            self.view?.hideLoader()
        }
    }
}

// MARK: - Private Methods.
extension MainViewModel {
    private func addToProdctsArray(_ prodct: Product){
        for (_ , value) in prodct {
            self.products.append(value)
        }
        handleProducts(products)
    }
    private func handleProducts(_ products: [ProductValue]?){
        if let products = products {
            for item in products {
                savedProductsManager.addNewProduct(item)
            }
            self.savedProducts = savedProductsManager.getSavedProducts()
            self.view?.setTotalCost(cost: getTotalCost())
            self.view?.reloadTable()
        }
    }
    private func getTotalCost() -> String{
        var sum: Int = 0
        for itme in savedProducts {
            sum = sum + (itme.retailPrice * itme.quantity)
        }
        return "\(sum)"
    }
    private func getDataFromCoreData(){
        savedProducts = savedProductsManager.getSavedProducts()
        self.view?.setTotalCost(cost: getTotalCost())
        self.view?.reloadTable()
    }
}
