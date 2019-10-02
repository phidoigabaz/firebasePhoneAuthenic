//
//  SearchViewController.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/13.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var searchBar = UISearchBar()
    fileprivate var searchTextField = SearchTextField()
    var notifyBarButton: MJBadgeBarButton!
    var weatherModel: [WeatherModel] = []
    var searchPresenter: SearchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(target: self, btnAction: #selector(backBarAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem.searchBarItem(target: self, btnAction: #selector(searchBarAction))
        searchPresenter = SearchPresenter(self)
        searchPresenter?.viewController = self
        tableView.register(UINib(nibName: SearchTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SearchTableViewCell.nibName())
    }
    
    func loadNiB() -> SearchTextField {
        let infoWindow = SearchTextField.instanceFromNib()
        return infoWindow
    }
    
    //MARk: ACTIONS
    @objc func backBarAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchBarAction() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTextField = loadNiB()
        searchTextField.frame = CGRect(x: 0, y: 0, width: 200, height: 35)
        searchTextField.delegate = self
        navigationItem.titleView = searchTextField
    }
}

extension SearchViewController: SearchPresenterView {
    func getWeatherCity(_ weatherModel: [WeatherModel]) {
        self.weatherModel = weatherModel
        tableView.reloadData()
    }
}

extension SearchViewController: SearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) {
        textField.resignFirstResponder()
        if textField.text!.count > 0 {
            if let keyWord = textField.text {
                searchPresenter?.getweatherCity(keyWord)
                tableView.reloadData()
            }
        } else {
            showAlertCancel(title: "Moi nhap", message: "Moi nhap")
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchTableViewCell.dequeueReuseCellWithNib(in: tableView, reuseIdentifier: SearchTableViewCell.nibName())
        cell.bindingWithModel(weatherModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
