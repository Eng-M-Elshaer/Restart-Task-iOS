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
    func showFetchAlert()
    func handleNoData(flag: Bool)
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
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getListData()
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
    func handleNoData(flag: Bool) {
        self.mainView?.handleNoData(flag: flag)
    }
    func showFetchAlert() {
        self.showFetchAlert(title: AlertTitle.alert, message: AlertMessage.yourListOnready) { _ in
            self.viewModel.getAPIData()
        }
    }
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
        mainView.setup()
    }
    @objc private func clearBtnTapped() {
        viewModel.clearTheData()
    }
    @objc private func fetch() {
        viewModel.checkPorducts()
    }
}

//MARK: - TableView DataSource.
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.productCell, for: indexPath) as? ProductCell else {return UITableViewCell()}
        cell.configCell(with: viewModel.getProducts(at: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteItem(product: viewModel.getProducts(at: indexPath.row))
        }
    }
}

//MARK: - TableView Delegate.
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDetailesVC.create(with: viewModel.getProducts(at: indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
