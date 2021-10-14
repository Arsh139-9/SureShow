//
//  AppointmentVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit
import Foundation
import Alamofire

class AppointmentVC : BaseVC, UITableViewDelegate,UITableViewDataSource,SegmentViewDelegate {
    
    @IBOutlet weak var tblAppointment: UITableView!
    @IBOutlet weak var segment3: SegmentView!
    @IBOutlet weak var segment4: SegmentView!
    @IBOutlet weak var segment2: SegmentView!
    @IBOutlet weak var segment1: SegmentView!
    @IBOutlet weak var verifiedIdentityPopUpView: UIView!
    @IBOutlet weak var verifiedPUpViewA: UIView!
    
    @IBOutlet weak var callPopUpView: UIView!
    //    let appoitmentCases = AppoitmentListing()
    var needToshowInfoView: Bool = false
    var hospitalListArr = [HospitalListData<AnyHashable>]()

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
        tblAppointment.delegate = self
        tblAppointment.dataSource = self
        
        segment1.btn.setTitle(LocalizableConstants.Controller.SureShow.all.localized(), for: .normal)
        segment2.btn.setTitle(LocalizableConstants.Controller.SureShow.confirmed.localized(), for: .normal)
        segment3.btn.setTitle(LocalizableConstants.Controller.SureShow.pending.localized(), for: .normal)
        segment4.btn.setTitle(LocalizableConstants.Controller.SureShow.queued.localized(), for: .normal)
        
        segment1.delegate = self
        segment2.delegate = self
        segment3.delegate = self
        segment4.delegate = self
        
        segment1.isSelected = true
        segment2.isSelected = true
//        segment2.isSelected = !segment1.isSelected
        segment3.isSelected = !segment1.isSelected
        segment4.isSelected = !segment1.isSelected
        
        var identifier = String(describing: AppointmentConfirmedTVCell.self)
        var nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblAppointment.register(nibCell, forCellReuseIdentifier: identifier)
        
        identifier = String(describing: PendingTVCell.self)
        nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblAppointment.register(nibCell, forCellReuseIdentifier: identifier)
        
        identifier = String(describing: QueueTVCell.self)
        nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblAppointment.register(nibCell, forCellReuseIdentifier: identifier)
        
        updateUI()
        
    }
    open func getHospitalListApi(){
        ModalResponse().getHospitalListApi(){ response in
            print(response)
            let getHospitalDataResp  = GetHospitalData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getHospitalDataResp?.message ?? ""
            if let status = getHospitalDataResp?.status{
                if status == 200{
                    self.hospitalListArr = getHospitalDataResp?.hospitalListArray ?? []
                }
                else if status == 401{
                    removeAppDefaults(key:"AuthToken")
                    appDel.logOut()
                }
                else{
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
    }
 
    
    
    func updateUI() {
        
        // Add the video preview layer to the view
        self.tabBarController?.tabBar.isHidden = false
        callPopUpView.isHidden = true
        verifiedIdentityPopUpView.isHidden = true
        verifiedPUpViewA.isHidden = true
        tblAppointment.reloadData()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource,UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if segment1.isSelected{
//            if indexPath.row % 2 == 0{
//                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentConfirmedTVCell.self)) as? AppointmentConfirmedTVCell {
//                    return cell
//                }
//            }else if indexPath.row % 3 == 0{
//                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PendingTVCell.self)) as? PendingTVCell {
//                    return cell
//                }
//            }else{
//                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QueueTVCell.self)) as? QueueTVCell {
//                    return cell
//                }
//            }
//        }else
        if segment2.isSelected {
            if indexPath.row % 2 == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentConfirmedTVCell.self)) as? AppointmentConfirmedTVCell {
                    return cell
                }
            }else if indexPath.row % 3 == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PendingTVCell.self)) as? PendingTVCell {
                    cell.btnAccept.addTarget(self, action: #selector(acceptBtnAction(_:)), for: .touchUpInside)
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QueueTVCell.self)) as? QueueTVCell {
                    return cell
                }
            }
//            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentConfirmedTVCell.self)) as? AppointmentConfirmedTVCell {
//                return cell
//            }
        }else if segment3.isSelected {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PendingTVCell.self)) as? PendingTVCell {
                cell.btnAccept.addTarget(self, action: #selector(acceptBtnAction(_:)), for: .touchUpInside)
                return cell
            }
        }else if segment4.isSelected{
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QueueTVCell.self)) as? QueueTVCell {
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segment4.isSelected{
            return 135
        }else if segment1.isSelected{
            if indexPath.row % 2 == 0 || indexPath.row % 3 == 0{
                return 160
            }else{
                return 135
            }
        }else{
            return 160
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segment2.isSelected{
            let controller =  NavigationManager.shared.appointmentDetailVC
            push(controller: controller)
        }else if  segment1.isSelected{
            if indexPath.row % 2 == 0{
                let controller =  NavigationManager.shared.appointmentDetailVC
                push(controller: controller)
            }else{}
        }
    }
    
    //------------------------------------------------------
    
    //MARK: SegmentViewDelegate
    
    func segment(view: SegmentView, didChange flag: Bool) {
        
        tblAppointment.reloadData()
        
        self.needToshowInfoView = true
        
        if view == segment1 {
            
            
            segment2.isSelected = false
            segment3.isSelected = false
            segment4.isSelected = false
            
        } else if view == segment2 {
            
            segment1.isSelected = false
            segment3.isSelected = false
            segment4.isSelected = false
        }
        else if view == segment3 {
            
            segment1.isSelected = false
            segment2.isSelected = false
            segment4.isSelected = false
        }
        else if view == segment4 {
            segment1.isSelected = false
            segment2.isSelected = false
            segment3.isSelected = false
        }
    }
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func crossPopupViewBtnAction(_ sender: Any) {
        self.verifiedIdentityPopUpView.isHidden = true
        verifiedPUpViewA.isHidden = true

    }
    
    @IBAction func callPopUpBtnAction(_ sender: Any) {
        self.callPopUpView.isHidden = false
        self.tabBarController?.tabBar.isHidden = true

    }
    
    @IBAction func callEndPUPViewBtnAction(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false

        self.verifiedIdentityPopUpView.isHidden = true
        verifiedPUpViewA.isHidden = true
        self.callPopUpView.isHidden = true

    }
    
    @objc func acceptBtnAction(_ sender: UIButton?) {
        verifiedPUpViewA.isHidden = false
        self.verifiedIdentityPopUpView.isHidden = false
        
//        var parentCell = sender?.superview
//
//        while !(parentCell is NotificationsTVC) {
//            parentCell = parentCell?.superview
//        }
//        var indexPath: IndexPath? = nil
//        let cell1 = parentCell as? NotificationsTVC
//        indexPath = notificationsTableView.indexPath(for: cell1!)
//        let detailId = notificationArray[indexPath!.row].detail_id
//
//        let notificationId = notificationArray[indexPath!.row].notification_id
//        acceptRejectApi(status: "1", id: detailId,notificationId: notificationId)
        
        
    }
    @IBAction func btnAdd(_ sender: Any) {
        let controller = NavigationManager.shared.addQueueVC
        controller.hospitalListArr = hospitalListArr
        push(controller: controller)
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        updateUI()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getHospitalListApi()
    }
    
    //------------------------------------------------------
}
