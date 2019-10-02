//
//  MenuViewModel.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import Foundation
import UIKit


struct MenuViewModel {
    var sections: [MenuSectionModel] = []
    
    init() {
        reloadMenuData()
    }
    
    mutating func reloadMenuData() {
        sections.append(sectionMenu)
    }
    
    private var sectionMenu: MenuSectionModel {
         get {
            var section = MenuSectionModel()
            section.rows.append(MenuRowModel(.hushList, "Hush List", "heart"))
            section.rows.append(MenuRowModel(.calendarCheck, "Calendar Check", ""))
            section.rows.append(MenuRowModel(.set, "Set", ""))
            section.rows.append(MenuRowModel(.setting, "Setting", ""))
            return section
        }
    }
    
    struct MenuSectionModel: PBaseSectionModel {
        var title: String
        var identifier: String
        var rows: [MenuRowModel] = []
        init() {
            title = ""
            identifier = MenuTableViewCell.nibName()
            rows = [MenuRowModel]()
        }
    }
}

struct MenuRowModel: PBaseRowModel {
    var title: String
    var desc: String
    var imageUrl: String
    var identifier: String
    var menuType: MenuType
    
    init(_ menuType: MenuType, _ title: String,_ desc: String,_ image: String) {
        self.title = title
        self.desc = desc
        self.imageUrl = image
        self.identifier = ""
        self.menuType = menuType
    }
    
    init(_ menuType: MenuType,_ title: String,_ image: String) {
        self.title = title
        self.desc = ""
        self.identifier = ""
        self.imageUrl = image
        self.menuType = menuType
    }
}
