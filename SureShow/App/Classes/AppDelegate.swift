//
//  AppDelegate.swift
//  SureShow
//
//  Created by Dharmani Apps on 18/09/21.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import IQKeyboardManagerSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    //------------------------------------------------------
    
    //MARK: Customs
    
    /// keyboard configutation
    private func configureKeboard() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarTintColor = SSColor.appBlack
        IQKeyboardManager.shared.enableAutoToolbar = true
//        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [ChatDetailsVC.self, ChatViewController.self]
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [UIScrollView.self,UIView.self,UITextField.self,UITextView.self,UIStackView.self]
        
    }
    /// to get custom added font names
    private func getCustomFontDetails() {
        #if DEBUG
        for family in UIFont.familyNames {
            let sName: String = family as String
            debugPrint("family: \(sName)")
            for name in UIFont.fontNames(forFamilyName: sName) {
                debugPrint("name: \(name as String)")
            }
        }
        #endif
    }
    
    public func configureNavigationBar() {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = SSColor.appBlack
            appearance.titleTextAttributes = [.foregroundColor:SSColor.appBlack, .font: SSFont.PoppinsRegular(size: SSFont.defaultRegularFontSize)]
            appearance.largeTitleTextAttributes = [.foregroundColor: SSColor.appBlack, .font: SSFont.PoppinsRegular(size: SSFont.defaultRegularFontSize)]
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 133.0/255.0, green: 38.0/255.0, blue:120.0/255.0, alpha: 1.0)], for: .selected)
            UINavigationBar.appearance().barTintColor = SSColor.appBlack
            UINavigationBar.appearance().tintColor = SSColor.appBlack
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = SSColor.appBlack
            UINavigationBar.appearance().tintColor = SSColor.appBlack
            UINavigationBar.appearance().isTranslucent = false
        }
    }
    
    func registerRemoteNotificaton(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
        } else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    func logOut(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: StoryboardName.Main, bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.LogInVC) as! LogInVC
        let nav = UINavigationController(rootViewController: homeViewController)
        nav.setNavigationBarHidden(true, animated: true)
        appdelegate.window?.rootViewController = nav
    }
    func loginToHomePage(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: StoryboardName.Main, bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
        homeViewController.selectedIndex = 0
        let nav = UINavigationController(rootViewController: homeViewController)
        nav.setNavigationBarHidden(true, animated: true)
        appdelegate.window?.rootViewController = nav
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        print("device token is \(deviceTokenString)")
        setAppDefaults(deviceTokenString, key: "DeviceToken")
    }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(1)

        window = UIWindow(frame: UIScreen.main.bounds)
        // Use the Firebase library to configure APIs.
        FirebaseApp.configure()
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-",
            AnalyticsParameterItemName:"dfsfaf",
            AnalyticsParameterContentType: "cont",
        ])
        configureKeboard()
        getCustomFontDetails()
        configureNavigationBar()
//        chekLoggedUser()
        registerRemoteNotificaton(application)
        //RealmManager.shared.save(channelDownload: false)
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.391271323, green: 0.1100022718, blue: 0.353789866, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.2668271065, green: 0.2587364316, blue: 0.2627768517, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 12)], for: .selected)
        window?.tintColor = SSColor.appBlack
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }


}

