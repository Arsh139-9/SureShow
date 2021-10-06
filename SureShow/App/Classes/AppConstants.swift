//
//  AppConstants.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

let kAppName : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? String()
let kAppBundleIdentifier : String = Bundle.main.bundleIdentifier ?? String()

enum DeviceType: String {
    case iOS = "iOS"
    case android = "android"
}

let emptyJsonString = "{}"

struct SSSettings {
    
    static let cornerRadius: CGFloat = 5
    static let borderWidth: CGFloat = 1
    static let shadowOpacity: Float = 0.4
    static let tableViewMargin: CGFloat = 50
    
    static let nameLimit = 20
    static let emailLimit = 70
    static let passwordLimit = 20
    
    static let footerMargin: CGFloat = 50
    static let profileImageSize = CGSize.init(width: 400, height: 400)
    static let profileBorderWidth: CGFloat = 4 }

struct SSColor {
    
    static let appButton = UIColor(named: "appColor")
    static let appBlack = UIColor(named: "appTitle")
    static let appWhite = UIColor(named: "appWhite")
    static let appGray = UIColor(named: "appGray")
    static let appDarkGray = UIColor(named: "appDarkGray")
    static let appHome = UIColor(named: "appHome")
    static let appHomeBlue = UIColor(named: "appHomeBlue")
    static let appCancel = UIColor(named: "appCancel")
    static let appBackground = UIColor(named: "appBackground")
    static let appBorder = UIColor(named: "appBorder")
    static let appColor = UIColor(named: "appColor")
    static let appLabel = UIColor(named: "appLabel")
}

struct SSFont {
    
    static let defaultRegularFontSize: CGFloat = 20.0
    static let zero: CGFloat = 0.0
    static let reduceSize: CGFloat = 3.0
    static let increaseSize : CGFloat = 2.0
    
    //"family: Poppins "
   
    static func PoppinsLight(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Light", size: size ?? defaultRegularFontSize)!
    }
    static func PoppinsMedium(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size ?? defaultRegularFontSize)!
    }
    static func PoppinsRegular(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size ?? defaultRegularFontSize)!
    }
    static func PoppinsSemiBold(size: CGFloat?) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size ?? defaultRegularFontSize)!
    }
}

struct SSImageName {

    static let iconCheck = "check"
    static let iconUncheck = "uncheck"
    static let iconEye = "eye"
    static let iconEyeShow = "eyeshow"
    static let iconAdd = "addd"
    static let iconCalendarB = "cal"
    static let iconCalendarW = "calendar"
    static let iconCancel = "cancel"
    static let iconConfirm = "conf"
    static let iconAbout = "about"
    static let iconBack = "back"
    static let iconCamera = "camera"
    static let iconEdit = "edit"
    static let iconLogout = "logout"
    static let iconPrivacy = "privacy"
    static let iconTerm = "term"
    static let iconHistory = "history"
    static let iconChangePassword = "change"
    static let iconUncle = "uncle"
    static let iconDropDown = "drop_down"
    static let iconCall = "call"
    static let iconDelete = "delete"
    static let iconHomeLogo = "home_logo"
    static let iconPlaceholder = "place"
    static let iconSplashLogo = "logo"
    static let iconAppointmentSelect = "appointment_sel"
    static let iconHomeSelect = "home_sel"
    static let iconNotificationSelect = "notification_sel"
    static let iconProfileSelect = "profile_sel"
    static let iconQueueSelect = "queue_sel"
    static let iconAppointmentUnSelect = "appointment_unsel"
    static let iconHomeUnSelect = "home_unsel"
    static let iconNotificationUnSelect = "notification_unsel"
    static let iconProfileUnSelect = "profile_unsel"
    static let iconQueueUnSelect = "queue_unsel"
}

struct SSScreenName {
      
    static let subscribed = "subscribed"
    static let home = "home"
    static let settings = "settings"
}
