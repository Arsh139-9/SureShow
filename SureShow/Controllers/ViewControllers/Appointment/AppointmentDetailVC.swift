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
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
