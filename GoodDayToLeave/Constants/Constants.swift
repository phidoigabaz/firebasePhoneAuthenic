//
//  Constants.swift
//  PamZ
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    //google
    static let GOOGLE_KEY = "AIzaSyA0qdLWJQSVmk317UDSZlN_w04RwE9d0BY"
    //hockey
    static let HOCKEY_APP_KEY = "6f8f7a02e962421fa35f656f19b7006b"
    //weather
    static let APIKEY_WEATHER = "787571b72c0a3fe449ccfdd6148c0947"
    //tripiso
    static let ACCOUNT_ID = "LUHN0K0F"
    static let API_TOKEN = "gqcjk61vs3klhtoag03so3pdognzyt9s"
    //uid
    static let kUID_USER = "kUID_USER"
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let isIpad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    static let isPhone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    static let iPhone = "iPhone"
    static let iPad = "iPad"
    static let screenWidth = UIScreen.main.nativeBounds.width
    static let screenHeight = UIScreen.main.nativeBounds.height
    
    static let urlAboutUs           = "https://www.pamz.jp"
    static var pStatusDPMenu        = "status_DPMenu"
    static let didShowTutorialPage  = "Constants.didShowTutorialPageNew"
    
    static let kDefaultRegion = "US"
    static let kDefaultLanguage = "en"
    
    static let kAppSettingsCountry   = "app_settings_country"
    static let kAppSettingsFirstLanguage = "app_settings_first_language"
    static let kAppSettingsSecondLanguage = "app_settings_second_language"
    static let pIsRTL               = "pIsRTL"
    
    static let kWalk = "walk"
    static let kTransit = "transit"
    static let kDriver = "driving"

    static let kGoogleMapMinimumZoom: Float = 6
    static let kRangeToGetNewSpot: Double = 5

    static let zoomIpad: Float = 16.9
    static let zoomIphone: Float = 17.5
    static let defaultLatitude = 35.544853791272345
    static let defaulLongitude = 139.76720770385737
    
    static let kURLIconWeather = "http://openweathermap.org/img/wn/"

}
