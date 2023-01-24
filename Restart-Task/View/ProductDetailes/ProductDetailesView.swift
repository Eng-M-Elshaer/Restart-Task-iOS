//
//  ProductDetailesView.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import SDWebImage

class ProductDetailesView: UIView {

    //MARK: - Outlets.
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDespLabel: UITextView!
    
    //MARK: - Public Methods.
    public func setup(){
        self.layoutIfNeeded()
        self.backgroundColor = Colors.mainBackColor
        productDespLabel.backgroundColor = Colors.mainBackColor
    }
    public func setupFor(product: SaveProductModel){
        setImage(with: product.imageURL)
        setProductInfo(for: productNameLabel, text: product.name)
        setProductInfo(for: productPriceLabel, text: "\(product.retailPrice) EGP")
        productDespLabel.text = product.theDesc
    }
}

//MARK: - Private Methods.
extension ProductDetailesView {
    private func setImage(with Url: String){
        productImageView.sd_setImage(with: URL(string: Url), placeholderImage: UIImage(named: Images.placeholder))
    }
    private func setProductInfo(for label: UILabel, text: String){
        label.text = text
    }
}
