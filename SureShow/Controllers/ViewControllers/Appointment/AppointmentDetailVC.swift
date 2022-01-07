//
//  AppointmentDetailVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit
import Foundation

class AppointmentDetailVC : BaseVC {
    
    @IBOutlet weak var lblHospitalName: SSMediumLabel!
    @IBOutlet weak var lblDoctorName: SSMediumLabel!
    @IBOutlet weak var lblAppointmentTime: SSMediumLabel!
    @IBOutlet weak var lblAppointmentDate: SSMediumLabel!
    @IBOutlet weak var lblParentName: SSMediumLabel!
    @IBOutlet weak var lblGender: SSMediumLabel!
    @IBOutlet weak var lblAge: SSMediumLabel!
    @IBOutlet weak var lblName: SSSemiboldLabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    var cUserName:String?
    var cFirstUserName:String?
    var cLastUserName:String?

    var cUserGender:Int?
    var cUserAge:Int?
    var cUserPGName:String?
    var cUserAppointmentTime:String?
    var cUserAppointmentDate:String?
    var cDoctorName:String?
    var cHospitalName:String?
    var cUserImage:String?
    
    
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
    
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = "\(cLastUserName ?? "") \(cFirstUserName ?? "")"
        lblAge.text = "\(cUserAge ?? 0)"
        lblHospitalName.text = ""
        lblDoctorName.text = cDoctorName
        lblParentName.text = cUserPGName
        lblAppointmentTime.text = cUserAppointmentTime
        lblAppointmentDate.text = cUserAppointmentDate
        cUserImage = cUserImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        self.imgProfile.sd_setImage(with: URL(string: cUserImage ?? ""), placeholderImage:UIImage(named:"placeholderProfileImg"))
        if cUserGender  == 1 {
         lblGender.text = "Male"
        }else if cUserGender  == 2{
          lblGender.text = "Female"
        }else{
            lblGender.text = "Others"
            
        }
//        lblGender.text = cUserGender
        
        
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
