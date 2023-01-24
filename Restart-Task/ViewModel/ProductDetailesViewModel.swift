//
//  ProductDetailesViewModel.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

protocol ProductDetailesViewModelProtocol {
    func getProduct() -> SaveProductModel
    func saveProduct()
}

class ProductDetailesViewModel {
    
    // MARK: - Private Properties
    private weak var view: ProductDetailesVCProtocol?
    private var product: SaveProductModel!
    private var savedProductsManager: SavedProductsManager = SavedProductsManager()
    
    // MARK: - Init
    init(view: ProductDetailesVCProtocol, product: SaveProductModel) {
        self.view = view
        self.product = product
    }
}

// MARK: - ProductDetailesViewModelProtocol
extension ProductDetailesViewModel: ProductDetailesViewModelProtocol {
    internal func saveProduct() {
        let product = ProductValue(barcode: product.barcode,
                                   description: product.theDesc,
                                   id: product.id,
                                   imageURL: product.imageURL,
                                   name: product.name,
                                   retailPrice: product.retailPrice,
                                   costPrice: product.costPrice)
        savedProductsManager.checkQuantity(product)
        self.view?.showAlert()
    }
    internal func getProduct() -> SaveProductModel {
        return self.product
    }
}
