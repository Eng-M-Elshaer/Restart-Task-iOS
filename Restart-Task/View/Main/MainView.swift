//
//  MainView.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import UIKit

class MainView: UIView {
    
    //MARK: - Outlets.
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var prodctTableView: UITableView!
    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var noDataImageView: UIImageView!
    
    //MARK: - Public Methods.
    public func setup(){
        setupTableView()
        setupAddButton()
        totalCostLabel.text = "..."
        self.backgroundColor = Colors.mainBackColor
        prodctTableView.backgroundColor = Colors.mainBackColor
        setupNoDataImage()
    }
    public func setupTotalPriceLabel(totalPrice: String){
        totalCostLabel.text = totalPrice + " EGP"
    }
    public func handleNoData(flag: Bool){
        if flag {
            noDataImageView.isHidden = false
            prodctTableView.isHidden = true
        } else {
            noDataImageView.isHidden = true
            prodctTableView.isHidden = false
        }
    }
}

//MARK: - Private Methods.
extension MainView {
    private func setupTableView(){
        prodctTableView.showsVerticalScrollIndicator = false
        prodctTableView.showsHorizontalScrollIndicator = false
    }
    private func setupAddButton(){
        addProductButton.setTitle("Add", for: .normal)
    }
    private func setupNoDataImage(){
        noDataImageView.isHidden = true
        noDataImageView.image = UIImage(named: Images.noData)
    }
}
