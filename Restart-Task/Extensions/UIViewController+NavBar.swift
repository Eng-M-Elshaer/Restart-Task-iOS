//
//  UIViewController+NavBar.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import UIKit

extension UIViewController {
    func setupRightButton(title: String, color: UIColor, action: Selector) {
        let rightBarButtonItem = UIBarButtonItem.init(title: title, style: .done, target: self, action: action)
        rightBarButtonItem.tintColor = color
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    func setViewControllerTitle(to title: String, fontColor: UIColor) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 25))
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.textColor = fontColor
        self.navigationItem.titleView = titleLabel
    }
    func setupLeftButton(title: String, color: UIColor, action: Selector) {
        let leftBarButtonItem = UIBarButtonItem.init(title: title, style: .done, target: self, action: action)
        leftBarButtonItem.tintColor = color
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}
