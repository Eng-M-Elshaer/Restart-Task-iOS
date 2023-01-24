//
//  Constants.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import UIKit

// MARK: - URLs.
struct URLs{
    static let base = "https://run.mocky.io/v3/"
    static let products = "4e23865c-b464-4259-83a3-061aaee400ba"
}

// MARK: - Storyboard.
struct StoryBoard {
    static var main = "Main"
}

// MARK: - ViewController.
struct ViewController {
    static let mainVC = "MainVC"
    static let cartVC = "CartVC"
    static let productDetailesVC = "ProductDetailesVC"
}

// MARK: - Cells.
struct CustomCell {
    static let productCell = "ProductCell"
}

// MARK: - Images.
struct Images {
    static let placeholder = "placeholder.png"
}

// MARK: - AlertTitle.
struct AlertTitle {
    static let sorry = "Sorry"
    static let success = "Success"
}

// MARK: - AlertMessage.
struct AlertMessage {
    static let somethingWentWrong = "Something went wrong"
    static let yourItemAdded = "Your Item has been added to the List."
    static let yourOderIsOnTheWay = "Your Ooder is on The Way."
    static let enterID = "Please Enter ID"
    static let enterName = "Please Enter Name"
    static let enterDesc = "Please Enter Desc"
    static let enterBarcore = "Please Enter Barcode"
    static let cost = "Please Enter Price Cost"
    static let retail = "Please Enter Price Retail"
}

// MARK: - ViewControllerTitle.
struct ViewControllerTitle {
    static let main = "Main Screen"
    static let cart = "Cart Screen"
    static let detailes = "Product Detailes Screen"
}

// MARK: - Colors.
struct Colors {
    static let mainBackColor: UIColor = .purple
}
