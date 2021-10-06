//
//  ProfileVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit
import Foundation
import Alamofire

class ProfileVC : BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblProfile: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    struct ProfileItems {
        
        static let changePassword = LocalizableConstants.Controller.Profile.changePassword
        static let changePasswordIcon = SSImageName.iconChangePassword
        static let about = LocalizableConstants.Controller.Profile.about
        static let aboutIcon = SSImageName.iconAbout
        static let privacyPolicy = LocalizableConstants.Controller.Profile.privacy
        static let privacyPolicyIcon = SSImageName.iconPrivacy
        static let termsOfServices = LocalizableConstants.Controller.Profile.termsOfService
        static let termsOfServicesIcon = SSImageName.iconTerm
        static let logout = LocalizableConstants.Controller.Profile.logout
        static let logoutIcon = SSImageName.iconLogout
        
    }
    
    var itemNormal: [ [String:String] ] {
        return [
            
            ["name": ProfileItems.changePassword, "image": ProfileItems.changePasswordIcon],
            ["name": ProfileItems.about, "image": ProfileItems.aboutIcon],
            ["name": ProfileItems.privacyPolicy, "image": ProfileItems.privacyPolicyIcon],
            ["name": ProfileItems.termsOfServices, "image": ProfileItems.termsOfServicesIcon],
            ["name": ProfileItems.logout, "image": ProfileItems.logoutIcon]
        ]
    }
    
    var items: [ [String: String] ] {
        
        return itemNormal
    }
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        tblProfile.delegate = self
        tblProfile.dataSource = self
        let identifier = String(describing: ProfileTVCell.self)
        let nibProfileCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblProfile.register(nibProfileCell, forCellReuseIdentifier: identifier)
    }
    
    func updateUI() {
        
        tblProfile.reloadData()
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnEdit(_ sender: Any) {
        let controller = NavigationManager.shared.editProfileVC
        push(controller: controller)
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let name = item["name"]
        let image = item["image"]!
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTVCell.self)) as? ProfileTVCell {
            cell.setup(image: image, name: name?.localized())
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let name = item["name"]
        if name == ProfileItems.changePassword{
            let controller = NavigationManager.shared.changePasswordVC
            controller.textTitle = name?.localized()
            push(controller: controller)
            
        }else if name == ProfileItems.about {
            
            let controller = NavigationManager.shared.aboutVC
            push(controller: controller)
            
        }else if name == ProfileItems.privacyPolicy {
            
            let controller = NavigationManager.shared.privacyVC
            push(controller: controller)
            
        }else if name == ProfileItems.termsOfServices {
            
            let controller = NavigationManager.shared.serviceVC
            push(controller: controller)
            
        }else if name == ProfileItems.logout {
            
            DisplayAlertManager.shared.displayAlertWithNoYes(target: self, animated: true, message: LocalizableConstants.ValidationMessage.confirmLogout.localized()) {
                
                //Nothing to handle
                
            } handlerYes: {
                
                LoadingManager.shared.showLoading()
                
            }
            
        }
    }
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        tblProfile.separatorStyle = .none
        imgProfile.circle()
    }
    
    //------------------------------------------------------
}
