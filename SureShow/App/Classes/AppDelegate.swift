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
class AppDelegate: UIResponder, UIApplicationDelegate {

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
        
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//            AnalyticsParameterItemID: "id-",
//            AnalyticsParameterItemName:"dfsfaf",
//            AnalyticsParameterContentType: "cont",
//        ])
       

        UINavigationController().interactivePopGestureRecognizer?.isEnabled = false
        configureKeboard()
        getCustomFontDetails()
//        configureNavigationBar()
//        chekLoggedUser()
        registerRemoteNotificaton(application)
        
        
        if launchOptions != nil
        {
            // opened from a push notification when the app is closed
            let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable : Any]
            if (userInfo != nil){
                if let apnsData = userInfo?["aps"] as? [String:Any]{
                    if let dataObj = apnsData["data"] as? [String:Any]{
                        let notificationType = dataObj["type"] as? String
                        let state = UIApplication.shared.applicationState
                        if state != .active{

                            if notificationType == "new_appointment"{
                                let storyBoard = UIStoryboard.init(name:StoryboardName.Main, bundle: nil)
                                let rootVc = storyBoard.instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
                                rootVc.selectedIndex = 1


                                let nav =  UINavigationController(rootViewController: rootVc)
                                nav.isNavigationBarHidden = true
                                if #available(iOS 13.0, *){
                                    if let scene = UIApplication.shared.connectedScenes.first{
                                         let windowScene = (scene as? UIWindowScene)
                                        print(">>> windowScene: \(windowScene)")
                                        let window: UIWindow = UIWindow(frame: (windowScene?.coordinateSpace.bounds)!)
                                        window.windowScene = windowScene //Make sure to do this
                                        window.rootViewController = nav
                                        window.makeKeyAndVisible()
                                        self.window = window
                                    }
                                } else {
                                    self.window?.rootViewController = nav
                                    self.window?.makeKeyAndVisible()
                                }
                            }
                          else {
                                let storyBoard = UIStoryboard.init(name:StoryboardName.Main, bundle: nil)
                                let rootVc = storyBoard.instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
                              rootVc.selectedIndex = 1


                                let nav =  UINavigationController(rootViewController: rootVc)
                                nav.isNavigationBarHidden = true
                                if #available(iOS 13.0, *){
                                    if let scene = UIApplication.shared.connectedScenes.first{
                                         let windowScene = (scene as? UIWindowScene)
                                        print(">>> windowScene: \(windowScene)")
                                        let window: UIWindow = UIWindow(frame: (windowScene?.coordinateSpace.bounds)!)
                                        window.windowScene = windowScene //Make sure to do this
                                        window.rootViewController = nav
                                        window.makeKeyAndVisible()
                                        self.window = window
                                    }
                                } else {
                                    self.window?.rootViewController = nav
                                    self.window?.makeKeyAndVisible()
                                }
                           }

                        }
                    }
                }
            }

        }
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

extension AppDelegate:UNUserNotificationCenterDelegate{
    
    // Receive displayed notifications for iOS 10 devices.
    
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if let userInfo = notification.request.content.userInfo as? [String:Any]{
            print(userInfo)
            if let apnsData = userInfo["aps"] as? [String:Any]{
                if let dataObj = apnsData["data"] as? [String:Any]{
                    let notificationType = dataObj["notification_type"] as? String
                    let state = UIApplication.shared.applicationState
                }
            }
        }
        
        
        
        
        // Print full message.
        //        print("user info is \(userInfo)")
        
        // Change this to your preferred presentation option
        // completionHandler([])
        //Show Push notification in foreground
//        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if let userInfo = response.notification.request.content.userInfo as? [String:Any]{
            print(userInfo)
            if let apnsData = userInfo["aps"] as? [String:Any]{
                if let dataObj = apnsData["data"] as? [String:Any]{
                    let notificationType = dataObj["type"] as? String

                    let state = UIApplication.shared.applicationState
                    if state != .active{
                        
                        if notificationType == "new_appointment"{
                            let storyBoard = UIStoryboard.init(name:StoryboardName.Main, bundle: nil)
                            let rootVc = storyBoard.instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
                            rootVc.selectedIndex = 1


                            let nav =  UINavigationController(rootViewController: rootVc)
                            nav.isNavigationBarHidden = true
                            if #available(iOS 13.0, *){
                                if let scene = UIApplication.shared.connectedScenes.first{
                                     let windowScene = (scene as? UIWindowScene)
                                    let window: UIWindow = UIWindow(frame: (windowScene?.coordinateSpace.bounds)!)
                                    window.windowScene = windowScene //Make sure to do this
                                    window.rootViewController = nav
                                    window.makeKeyAndVisible()
                                    self.window = window
                                }
                            } else {
                                self.window?.rootViewController = nav
                                self.window?.makeKeyAndVisible()
                            }
                        }
                      else {
                            let storyBoard = UIStoryboard.init(name:StoryboardName.Main, bundle: nil)
                            let rootVc = storyBoard.instantiateViewController(withIdentifier:"TabBarVC") as! TabBarVC
                          rootVc.selectedIndex = 1


                            let nav =  UINavigationController(rootViewController: rootVc)
                            nav.isNavigationBarHidden = true
                            if #available(iOS 13.0, *){
                                if let scene = UIApplication.shared.connectedScenes.first{
                                     let windowScene = (scene as? UIWindowScene)
                                    let window: UIWindow = UIWindow(frame: (windowScene?.coordinateSpace.bounds)!)
                                    window.windowScene = windowScene //Make sure to do this
                                    window.rootViewController = nav
                                    window.makeKeyAndVisible()
                                    self.window = window
                                }
                            } else {
                                self.window?.rootViewController = nav
                                self.window?.makeKeyAndVisible()
                            }
                       }

                    }
                }
            }
        }
        completionHandler()
    }
    
    func convertStringToDictionary(json: String) -> [String: AnyObject]? {
        if let data = json.data(using: String.Encoding.utf8) {
            let json = try? JSONSerialization.jsonObject(with: data, options:.mutableContainers) as? [String: AnyObject]
            //            if let error = error {
            //            print(error!)
            //}
            return json!
        }
        return nil
    }
    
}
