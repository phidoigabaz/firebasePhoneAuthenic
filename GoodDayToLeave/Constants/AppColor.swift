//
//  AppColor.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import Foundation
import UIKit

class AppColor: NSObject {
    class func navigationColor() -> UIColor {
        return UIColor.init(red: 245.0/255.0, green: 244.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    }
    
    class func iconTinColor() -> UIColor {
        return UIColor.init(red: 105.0/255.0, green: 105.0/255.0, blue: 105.0/255.0, alpha: 1.0)
    }
    
    class func textColor() -> UIColor {
        return UIColor.init(red: 52.0/255.0, green: 52.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    }
    
    class func mainColor() -> UIColor {
        return UIColor.init(red: 249.0/255.0, green: 170.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    }
    
    class func backgroundApp() -> UIColor {
        return UIColor.init(red: 253.0/255.0, green: 253.0/255.0, blue: 253.0/255.0, alpha: 1.0)
    }
    
    class func darkGreenColor() -> UIColor {
        return UIColor.init(red: 121.0/255.0, green: 167.0/255.0, blue: 171.0/255.0, alpha: 1.0)
    }
    
    class func textColorDropDown() -> UIColor {
        return UIColor.init(red: 159.0/255.0, green: 170.0/255.0, blue: 175.0/255.0, alpha: 1.0)
    }
    
    class func backgoundMainColor() -> UIColor {
        return "F9AA4C".hexColor
    }
}
