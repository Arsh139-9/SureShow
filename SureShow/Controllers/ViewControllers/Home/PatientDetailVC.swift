//
//  PatientDetailVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit
import Foundation

class PatientDetailVC : BaseVC {
    
    @IBOutlet weak var userNameLbl: SSSemiboldLabel!
    
    @IBOutlet weak var userAgeLbl: SSMediumLabel!
    
    @IBOutlet weak var userGenderLbl: SSMediumLabel!
    
    //MARK:LoggedInUserName
    @IBOutlet weak var parentGuardianNameLbl: SSMediumLabel!
    
    @IBOutlet weak var appointmentDateLbl: SSRegularLabel!
    
    @IBOutlet weak var appointmentTimeLbl: SSRegularLabel!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    var id:Int?
    var userName:String?
    var firstName:String?
    var lastName:String?

    var userAge:String?
    var userImage:String?
    var userGender:String?
    var parentGuardianName:String?
    var appointmentDate:String?
    var appointmentTime:String?
    lazy var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    var relationShipId:Int?
    
    var relationshipListArr = [RelationshipListData<AnyHashable>]()
    
    
    
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnEdit(_ sender: Any) {
        let vc =  NavigationManager.shared.editPatientDetailVC
//        let userN = userNameLbl.text
//        let arr = userN?.components(separatedBy:" ")
//        vc.firstName = arr?[1]
//        vc.lastName = arr?[0]
        vc.userName = userNameLbl.text
        vc.firstName = firstName
        vc.lastName = lastName
        vc.id = id
        vc.userAge = userAge
        vc.userImage = userImage
        vc.relationshipListArr = relationshipListArr
        vc.relationShipId = relationShipId
        if userGender  == "Male"{
            vc.userGender = 1
        }else if userGender  == "Female"{
            vc.userGender = 2
        }else {
            vc.userGender = 3
        }
        push(controller: vc)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameLbl.text = "\(lastName ?? "") \(firstName ?? "")"
        
        userGenderLbl.text = userGender
        parentGuardianNameLbl.text = parentGuardianName
        appointmentDateLbl.text = appointmentDate
        appointmentTimeLbl.text = appointmentTime
        
        
        let birthday = dateFormatter.date(from: userAge ?? "")
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        userAgeLbl.text = "\(age) years old"
        userImage = userImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        self.imgProfile.sd_setImage(with: URL(string: userImage ?? ""), placeholderImage:UIImage(named:"placeholderProfileImg"))
    }
    
    //------------------------------------------------------
}
