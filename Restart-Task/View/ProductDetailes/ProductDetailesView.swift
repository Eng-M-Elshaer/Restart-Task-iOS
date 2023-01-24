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
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var productDespTextView: UITextView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: - Public Methods.
    public func setup(){
        self.layoutIfNeeded()
        self.backgroundColor = Colors.mainBackColor
        productDespTextView.backgroundColor = Colors.mainBackColor
        containerView.backgroundColor = Colors.mainBackColor
    }
    public func setupFor(product: SaveProductModel){
        setImage(with: product.imageURL)
        setProductInfo(for: productNameLabel, text: product.name)
        setProductInfo(for: productPriceLabel, text: "\(product.retailPrice) EGP")
        productDespTextView.text = product.theDesc
        barcodeImageView.image = generateBarcode(from: product.barcode)
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
    private func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
