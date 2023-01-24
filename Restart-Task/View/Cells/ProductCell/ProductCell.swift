//
//  ProductCell.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import SDWebImage

class ProductCell: UITableViewCell {

    //MARK: - Outlets.
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCostLabel: UILabel!
    @IBOutlet weak var productDescpLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    //MARK: - LifeCycle Methods.
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Colors.mainBackColor
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Public Methods.
    public func configCell(with porduct: SaveProductModel){
        productImageView.sd_setImage(with: URL(string: porduct.imageURL), placeholderImage: UIImage(named: Images.placeholder))
        productNameLabel.text = porduct.name
        productCostLabel.text = "\(porduct.retailPrice) EGP"
        productQuantityLabel.text = "No. \(porduct.quantity)"
        productDescpLabel.text = porduct.theDesc.description
    }
}
