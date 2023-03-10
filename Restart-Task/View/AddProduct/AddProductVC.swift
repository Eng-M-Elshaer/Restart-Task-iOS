//
//  AddProductVC.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import UIKit

protocol AddProductVCProtocol: AnyObject {
    func showAlertWith(title: String, message: String)
    func showSucess()
}

class AddProductVC: UIViewController {

    //MARK: - Outlets.
    @IBOutlet weak var addProductView: AddProductView!
    
    // MARK: - Properties
    private var viewModel: AddProductViewModelProtocol!

    //MARK: - LifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Class Methods.
    class func create() -> AddProductVC {
        let addProductVC: AddProductVC = UIViewController.create(storyboardName: StoryBoard.main, identifier: "\(AddProductVC.self)")
        addProductVC.viewModel = AddProductViewModel(view: addProductVC)
        return addProductVC
    }
    
    //MARK: - Actions.
    @IBAction func addBtnTapped(_ sender: UIButton) {
        let data = ProductVaildationData(addProductView?.idTextField.text,
                                         addProductView?.nameTextField.text,
                                         addProductView?.barcodeTextField.text,
                                         addProductView?.descTextField.text,
                                         addProductView?.costPriceTextField.text,
                                         addProductView?.retailPriceTextField.text)
        viewModel.validtor(product: data)
    }
}

//MARK: - AddProductVCProtocol.
extension AddProductVC: AddProductVCProtocol {
    func showSucess() {
        self.showSuccessAlert(title: AlertTitle.success, message: AlertMessage.yourItemAdded) { _ in
            self.backToMain()
        }
    }
    func showAlertWith(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
}

//MARK: - Private Methods.
extension AddProductVC {
    private func setupUI(){
        self.setViewControllerTitle(to: ViewControllerTitle.main, fontColor: .black)
        addProductView.setup()
    }
    private func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
}
