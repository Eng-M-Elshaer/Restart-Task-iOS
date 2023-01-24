//
//  AddProductViewModel.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import Foundation

protocol AddProductViewModelProtocol {
    func validtor(product: ProductVaildationData)
}

typealias ProductVaildationData = (id: String?, name: String?, barcode: String?, desc: String?, cost: String?, retail: String?)

class AddProductViewModel {
    
    // MARK: - Private Properties
    private weak var view: AddProductVCProtocol?
    private var savedProductsManager: SavedProductsManager = SavedProductsManager()
    
    // MARK: - Init
    init(view: AddProductVCProtocol) {
        self.view = view
    }
}

// MARK: - MainViewModelProtocol
extension AddProductViewModel: AddProductViewModelProtocol {
    func validtor(product: ProductVaildationData) {
        if isVaildData(product: product) {
            let product = ProductValue(barcode: product.barcode!,
                                       description: product.desc!,
                                       id: product.id!,
                                       imageURL: "",
                                       name: product.name!,
                                       retailPrice: Int(product.retail ?? "")!,
                                       costPrice: Int(product.cost ?? ""))
            saveProduct(product: product)
            self.view?.backToMain()
        }
    }
    
    private func isVaildData(product: ProductVaildationData) -> Bool {
        guard product.id?.trimmed != "" else {
            self.view?.showAlertWith(title: AlertTitle.sorry, message: AlertMessage.enterID)
            return false
        }
        guard product.name?.trimmed != "" else {
            self.view?.showAlertWith(title: AlertTitle.sorry, message: AlertMessage.enterName)
            return false
        }
        guard product.barcode?.trimmed != "" else {
            self.view?.showAlertWith(title: AlertTitle.sorry, message: AlertMessage.enterBarcore)
            return false
        }
        guard product.desc?.trimmed != "" else {
            self.view?.showAlertWith(title: AlertTitle.sorry, message: AlertMessage.enterDesc)
            return false
        }
        guard product.retail?.trimmed != "" else {
            self.view?.showAlertWith(title: AlertTitle.sorry, message: AlertMessage.retail)
            return false
        }
        guard product.cost?.trimmed != "" else {
            self.view?.showAlertWith(title: AlertTitle.sorry, message: AlertMessage.cost)
            return false
        }
        return true
    }
    private func saveProduct(product: ProductValue) {
        savedProductsManager.checkQuantity(product)
        self.view?.showAlertWith(title: AlertTitle.success, message: AlertMessage.yourItemAdded)
    }
}

