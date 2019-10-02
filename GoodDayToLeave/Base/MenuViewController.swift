//
//  MenuViewController.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import MMDrawerController
import FirebaseAuth

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel = MenuViewModel()
    var selectedMenuIndex: MenuType = .hushList
    lazy var homeNav = BaseNavigationController(rootViewController: HomeViewController.initWithDefaultNib())
    lazy var calendarCheckNav = BaseNavigationController(rootViewController: CalendarCheckViewController.initWithDefaultNib())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupMenuView() {
        for section in viewModel.sections {
            tableView.register(UINib(nibName: section.identifier, bundle: nil), forCellReuseIdentifier: section.identifier)
        }
        tableView.reloadData()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = viewModel.sections[indexPath.section]
        let rowModel = sectionModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionModel.identifier, for: indexPath) as! MenuTableViewCell
        cell.bindingWithModel(rowModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MenuHeaderView.dequeueReuseHeaderWithNib(in: tableView, reuseIdentifier: MenuHeaderView.nibName())
        header.delegate = self
        return header
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionModel = viewModel.sections[indexPath.section]
        let rowModel = sectionModel.rows[indexPath.row]
        switch rowModel.menuType {
        case .hushList:
            self.mm_drawerController.centerViewController = homeNav
            selectedMenuIndex = rowModel.menuType
            break
        case .calendarCheck:
            self.mm_drawerController.centerViewController = calendarCheckNav
            selectedMenuIndex = rowModel.menuType
        default:
            break
        }
    }
}

extension MenuViewController: MenuHeaderViewDelegate {
    func didSelectsignOut(_ view: UITableViewHeaderFooterView, _ sender: Any) {
        FirebaseManager.sharedInstance.doLogout()
    }
}
