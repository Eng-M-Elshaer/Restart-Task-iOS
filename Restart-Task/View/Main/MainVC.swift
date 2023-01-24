//
//  MainVC.swift
//  RestartTask
//
//  Created by Mohamed Elshaer on 23/01/2023.
//

import UIKit

protocol MainVCProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func reloadTable()
    func showAlert(with error: String)
    func setTotalCost(cost: String)
}

class MainVC: UIViewController {

    //MARK: - Outlets.
    @IBOutlet weak var mainView: MainView!
    
    // MARK: - Properties
    private var viewModel: MainViewModelProtocol!
    
    //MARK: - LifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mainView.setup()
        setupTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getLoclData()
    }
    
    //MARK: - Class Methods.
    class func create() -> MainVC {
        let mainVC: MainVC = UIViewController.create(storyboardName: StoryBoard.main, identifier: "\(MainVC.self)")
        mainVC.viewModel = MainViewModel(view: mainVC)
        return mainVC
    }
    
    //MARK: - Actions.
    @IBAction func addBtnTapped(_ sender: UIButton) {
        let addProductVC = AddProductVC.create()
        self.navigationController?.pushViewController(addProductVC, animated: true)
    }
}

//MARK: - MainVC Protocol.
extension MainVC: MainVCProtocol {
    func setTotalCost(cost: String) {
        self.mainView?.setupTotalPriceLabel(totalPrice: cost)
    }
    func showLoader() {
        self.mainView?.showLoader()
    }
    func hideLoader() {
        self.mainView?.hideLoader()
    }
    func reloadTable() {
        self.mainView?.prodctTableView.reloadData()
    }
    func showAlert(with error: String) {
        self.showAlert(title: AlertTitle.sorry, message: error)
    }
}

//MARK: - Private Methods.
extension MainVC {
    private func setupTableView(){
        self.mainView?.prodctTableView.dataSource = self
        self.mainView?.prodctTableView.delegate = self
        self.mainView?.prodctTableView.register(UINib(nibName: CustomCell.productCell, bundle: nil), forCellReuseIdentifier: CustomCell.productCell)
    }
    private func setupUI(){
        self.setViewControllerTitle(to: ViewControllerTitle.main, fontColor: .black)
        self.setupRightButton(title: "Clear", color: .black, action: #selector(clearBtnTapped))
        self.setupLeftButton(title: "Fetch", color: .black, action: #selector(fetch))
    }
    @objc private func clearBtnTapped() {
        viewModel.clearTheData()
    }
    @objc private func fetch() {
        viewModel.getLoclData()
    }
}

//MARK: - TableView DataSource.
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProducts().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.productCell, for: indexPath) as? ProductCell else {return UITableViewCell()}
        let products: [SaveProductModel] = viewModel.getProducts()
        cell.configCell(with: products[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let products: [SaveProductModel] = viewModel.getProducts()
            viewModel.deleteItem(product: products[indexPath.row])
        }
    }
}

//MARK: - TableView Delegate.
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let products: [SaveProductModel] = viewModel.getProducts()
        let vc = ProductDetailesVC.create(with: products[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
