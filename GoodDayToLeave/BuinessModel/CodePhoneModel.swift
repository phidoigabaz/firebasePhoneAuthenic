//
//  CodePhoneModel.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/23.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import SwiftyJSON

class CodePhoneModel: NSObject {
    var code: String
    //var name: String
    
    init(_ dto: CodePhoneDTO) {
        self.code = dto.code
        //self.name = dto.name
    }
}
