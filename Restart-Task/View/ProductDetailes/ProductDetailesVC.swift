//
//  ProductDetailesVC.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import UIKit

protocol ProductDetailesVCProtocol: AnyObject {
    func showAlert()
}

class ProductDetailesVC: UIViewController {

    //MARK: - Outlets.
    @IBOutlet weak var productDetailesView: ProductDetailesView!
    
    // MARK: - Properties
    private var viewModel: ProductDetailesViewModelProtocol!
    
    //MARK: - LifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        productDetailesView.setup()
        setupProductInfo()
    }
    
    //MARK: - Class Methods.
    class func create(with product: SaveProductModel) -> ProductDetailesVC {
        let productDetailesVC: ProductDetailesVC = UIViewController.create(storyboardName: StoryBoard.main,
                                                                           identifier: "\(ProductDetailesVC.self)")
        productDetailesVC.viewModel = ProductDetailesViewModel(view: productDetailesVC, product: product)
        return productDetailesVC
    }
}

//MARK: - ProductDetailesVCProtocol.
extension ProductDetailesVC: ProductDetailesVCProtocol {
    func showAlert() {
        self.showSuccessAlert(title: AlertTitle.success, message: AlertMessage.yourItemAdded) { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - Private Methods.
extension ProductDetailesVC {
    private func setupProductInfo() {
        let product: SaveProductModel = viewModel.getProduct()
        self.productDetailesView?.setupFor(product: product)
    }
    private func setupUI(){
        self.setViewControllerTitle(to: ViewControllerTitle.detailes, fontColor: .black)
    }
}
