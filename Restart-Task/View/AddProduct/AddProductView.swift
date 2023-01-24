//
//  AddProductView.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import UIKit

class AddProductView: UIView {

    //MARK: - Outlets.
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageUrlImageView: UITextField!
    @IBOutlet weak var barcodeTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var costPriceTextField: UITextField!
    @IBOutlet weak var retailPriceTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
  
    //MARK: - Public Methods.
    public func setup(){
        setupTextFields()
        setupAddButton()
        self.backgroundColor = Colors.mainBackColor
    }
}

//MARK: - Private Methods.
extension AddProductView {
    private func setupTextFields(){
        idTextField.placeholder = "Product ID"
        idTextField.keyboardType = .asciiCapableNumberPad
        nameTextField.placeholder = "Product Name"
        imageUrlImageView.placeholder = "Product Image Url"
        barcodeTextField.placeholder = "Product barcode"
        barcodeTextField.keyboardType = .asciiCapableNumberPad
        descTextField.placeholder = "Product Desc"
        costPriceTextField.placeholder = "Product Cost Price"
        costPriceTextField.keyboardType = .asciiCapableNumberPad
        retailPriceTextField.placeholder = "Product Retail Price"
        retailPriceTextField.keyboardType = .asciiCapableNumberPad
    }
    private func setupAddButton(){
        addButton.setTitle("Sumbit", for: .normal)
    }
}
