//
//  Product.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import Foundation

typealias Product = [String: ProductValue]

// MARK: - PorductValue
struct ProductValue: Decodable {
    let barcode, description, id: String
    let imageURL: String
    let name: String
    let retailPrice: Int
    let costPrice: Int?

    enum CodingKeys: String, CodingKey {
        case barcode, description, id, name
        case imageURL = "image_url"
        case retailPrice = "retail_price"
        case costPrice = "cost_price"
    }
}
