//
//  NavigationManager.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

struct SSStoryboard {
        
    public static let main: String = "Main"
 
}

struct SSNavigation {
        
    public static let signInOption: String = "navigationSingInOption"
}

class NavigationManager: NSObject {
    
    let window = AppDelegate.shared.window
    
    //------------------------------------------------------
    
    //MARK: Storyboards
    
    let mainStoryboard = UIStoryboard(name: SSStoryboard.main, bundle: Bundle.main)
//    let loaderStoryboard = UIStoryboard(name: SSStoryboard.loader, bundle: Bundle.main)
    
    //------------------------------------------------------
    
    //MARK: Shared
    
    static let shared = NavigationManager()
    
    //------------------------------------------------------
    
    //MARK: UINavigationController
       
    var signInOptionsNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: SSNavigation.signInOption) as! UINavigationController
    }
    
    //------------------------------------------------------
    
    //MARK: RootViewController
    
    func setupSingInOption() {
        
        let controller = signInOptionsNC
        AppDelegate.shared.window?.rootViewController = controller
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewControllers
    
    public var logInVC: LogInVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: LogInVC.self)) as! LogInVC
    }
    public var forgotPasswordVC: ForgotPasswordVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: ForgotPasswordVC.self)) as! ForgotPasswordVC
    }
    public var changePasswordVC: ChangePasswordVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: ChangePasswordVC.self)) as! ChangePasswordVC
    }
    public var editProfileVC: EditProfileVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: EditProfileVC.self)) as! EditProfileVC
    }
    public var signUpVC: SignUpVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: SignUpVC.self)) as! SignUpVC
    }
    public var addQueueVC: AddQueueVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: AddQueueVC.self)) as! AddQueueVC
    }
    public var editPatientDetailVC: EditPatientDetailVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: EditPatientDetailVC.self)) as! EditPatientDetailVC
    }
    public var addPatientVC: AddPatientVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: AddPatientVC.self)) as! AddPatientVC
    }
    public var homeVC: HomeVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: HomeVC.self)) as! HomeVC
    }
    public var appointmentVC: AppointmentVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: AppointmentVC.self)) as! AppointmentVC
    }
    public var notificationVC: NotificationVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: NotificationVC.self)) as! NotificationVC
    }
    public var profileVC: ProfileVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: ProfileVC.self)) as! ProfileVC
    }
    public var tabBarVC: TabBarVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: TabBarVC.self)) as! TabBarVC
    }
    public var appointmentDetailVC: AppointmentDetailVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: AppointmentDetailVC.self)) as! AppointmentDetailVC
    }
    public var appointmentHistoryVC: AppointmentHistoryVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: AppointmentHistoryVC.self)) as! AppointmentHistoryVC
    }
    public var patientDetailVC: PatientDetailVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: PatientDetailVC.self)) as! PatientDetailVC
    }
    public var serviceVC: ServiceVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: ServiceVC.self)) as! ServiceVC
    }
    public var aboutVC: AboutVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: AboutVC.self)) as! AboutVC
    }
    public var privacyVC: PrivacyVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: PrivacyVC.self)) as! PrivacyVC
    }
    

    
 
    
    //------------------------------------------------------
}
