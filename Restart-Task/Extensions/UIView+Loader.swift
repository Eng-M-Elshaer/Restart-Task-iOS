//
//  UIView+Loader.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import UIKit

//MARK:- Public Methods
extension UIView {
    func showLoader() {
        let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    func hideLoader() {
        if let activityIndicator = viewWithTag(333) {
            activityIndicator.removeFromSuperview()
        }
    }
}

//MARK:- Private Methods
extension UIView {
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = self.bounds
        activityIndicator.center = self.center
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.tag = 333
        return activityIndicator
    }
}
