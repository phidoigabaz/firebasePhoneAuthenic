//
//  Protocols.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import Foundation

protocol PBaseSectionModel {
    var title: String {set get}
    associatedtype Cell
    var rows: [Cell] {set get}
}

protocol PBaseRowModel {
    var title: String {set get}
    var desc: String {set get}
    var imageUrl: String {set get}
    var identifier: String {set get}
}

