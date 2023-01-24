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
    
    //MARK: - Public Methods.
    public func setup(){
        setupTableView()
        setupAddButton()
        self.backgroundColor = Colors.mainBackColor
        prodctTableView.backgroundColor = Colors.mainBackColor
    }
    public func setupTotalPriceLabel(totalPrice: String){
        totalCostLabel.text = totalPrice + " EGP"
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
}
