//
//  UIViewController+NavBar.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//


import UIKit

extension UIViewController {
    /// add alert function to the VC
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showSuccessAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
