//
//  CodePhoneDTO.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/23.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import SwiftyJSON

class CodePhoneDTO: NSObject {
    var code: String
    //var name: String
    
    init(_ json: JSON) {
        code = json["code"].stringValue
        //name = json["name"].stringValue
    }
}
