//
//  AppointmentVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit
import Foundation
import Alamofire
import KRPullLoader


class AppointmentVC : BaseVC, UITableViewDelegate,UITableViewDataSource,SegmentViewDelegate {
    
    @IBOutlet weak var tblAppointment: UITableView!
    @IBOutlet weak var segment3: SegmentView!
    @IBOutlet weak var segment4: SegmentView!
    @IBOutlet weak var segment2: SegmentView!
    @IBOutlet weak var segment1: SegmentView!
    @IBOutlet weak var verifiedIdentityPopUpView: UIView!
    @IBOutlet weak var verifiedPUpViewA: UIView!
    
    @IBOutlet weak var noFoundAppointmentTypeView: UIView!
    @IBOutlet weak var noFoundAppointmentLbl: SSSemiboldLabel!
    
    @IBOutlet weak var callPopUpView: UIView!
    //    let appoitmentCases = AppoitmentListing()
    var needToshowInfoView: Bool = false
    var hospitalListArr = [HospitalListData<AnyHashable>]()
    var addQueueListArr = [AddQueueListData<AnyHashable>]()
    var addQueueListNUArr = [AddQueueListData<AnyHashable>]()
    
    //GetPendingAppointmentData
    var patientSId:Int?
    var lastPageNo = 1
    
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
        segment2.btn.setTitle(LocalizableConstants.Controller.SureShow.queued.localized(), for: .normal)
        segment3.btn.setTitle(LocalizableConstants.Controller.SureShow.pending.localized(), for: .normal)
        segment4.btn.setTitle(LocalizableConstants.Controller.SureShow.confirmed.localized(), for: .normal)
        
        segment1.delegate = self
        segment2.delegate = self
        segment3.delegate = self
        segment4.delegate = self
        
        segment1.isSelected = true
        segment2.isSelected = true
        
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
        
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tblAppointment.addPullLoadableView(loadMoreView, type: .loadMore)
        
    }
    open func getCPQListApi(statusS:Int){
        
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        ModalResponse().getCPQListApi(perPage:5000, page: lastPageNo, status: statusS){ response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            
            let getQueueDataResp  = GetAddQueueData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getQueueDataResp?.message ?? ""
            if let status = getQueueDataResp?.status{
                if status == 200{
//                    self.lastPageNo = self.lastPageNo + 1
                    let getQListArr = getQueueDataResp?.addQueueListArray ?? []
                    
                    if getQListArr.count != 0{
                        DispatchQueue.main.async {
                            //                            self.noDataFoundView.isHidden = true
                        }
                        for i in 0..<getQListArr.count {
                            self.addQueueListNUArr.append(getQListArr[i])
                        }
                        self.addQueueListNUArr.sort {
                            $0.id > $1.id
                        }
                        let uniquePosts = self.addQueueListNUArr.unique{$0.id }
                        
                        self.addQueueListArr = uniquePosts
                        
                        
                    }else{
                        DispatchQueue.main.async {
                            //                            self.noDataFoundView.isHidden = false
                        }
                    }
                    
                    
                    self.updateUI()
                }
                else if status == 401{
                    removeAppDefaults(key:"AuthToken")
                    appDel.logOut()
                }
                else{
                    if statusS == 3{
                        if self.addQueueListNUArr.count == 0{
                            self.noFoundAppointmentTypeView.isHidden = false
                            self.addQueueListArr.removeAll()
                            self.noFoundAppointmentLbl.text = "No appointment yet!"

                        }
                    }else if statusS == 2{
                        if self.addQueueListNUArr.count == 0{
                            self.noFoundAppointmentTypeView.isHidden = false
                            self.addQueueListArr.removeAll()
                            self.noFoundAppointmentLbl.text = "No appointment yet!"
                        }
                    }else{
                        if self.addQueueListNUArr.count == 0{
                        self.noFoundAppointmentTypeView.isHidden = false
                            self.addQueueListArr.removeAll()
                        self.noFoundAppointmentLbl.text = "No queue found!"
                        }

                    }

                    //
                    self.updateUI()
//                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
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
    
    open func deleteQueueApi(){
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        AFWrapperClass.requestPostWithMultiFormData(kBASEURL + WSMethods.deleteQueueList, params: generatingParameters(), headers: headers) { response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            let message = response["message"] as? String ?? ""
            if let status = response["status"] as? Int {
                if status == 200{
                    showAlertMessage(title: kAppName.localized(), message: message , okButton: "OK", controller: self) {
                        self.lastPageNo = 1
                        self.addQueueListNUArr.removeAll()
                        self.getCPQListApi(statusS: 1)
                    }
                }
                else if status == 401{
                    removeAppDefaults(key:"AuthToken")
                    appDel.logOut()
                }
                else{
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } failure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
    }
    func generatingParameters() -> [String:AnyObject] {
        var parameters:[String:AnyObject] = [:]
        
        parameters["id"] = patientSId as AnyObject
        
        //        parameters["usertype"] = "1" as AnyObject
        
        print(parameters)
        return parameters
    }
    
    @objc func deleteQueueBtnClicked(_ sender: Any?) {
        
        let button = sender as? UIButton
        var parentCell = button?.superview
        
        while !(parentCell is UITableViewCell) {
            parentCell = parentCell?.superview
        }
        var indexPath: IndexPath? = nil
        if let cell = parentCell as? UITableViewCell {
            indexPath = tblAppointment.indexPath(for: cell)
        }
        patientSId = addQueueListArr[indexPath?.row ?? 0].id
        
        deleteQueueApi()
    
        
        
        
        
    }
  
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource,UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addQueueListArr.count
       
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if segment2.isSelected {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QueueTVCell.self)) as? QueueTVCell {
                cell.lblAge.text = "\(addQueueListArr[indexPath.row].age) years old"
                cell.lblName.text = "\(addQueueListArr[indexPath.row].last_name) \(addQueueListArr[indexPath.row].first_name)"
                if addQueueListArr[indexPath.row].gender  == 1{
                    cell.lblGender.text = "Male"
                }else if addQueueListArr[indexPath.row].gender  == 2{
                    cell.lblGender.text = "Female"
                }else{
                    cell.lblGender.text = "Others"
                    
                }
                
                var sPhotoStr = addQueueListArr[indexPath.row].image
                sPhotoStr = sPhotoStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
                cell.imgMain.sd_setImage(with: URL(string: sPhotoStr ), placeholderImage:UIImage(named:"placeholderProfileImg"))
                cell.deleteQueueBtn.addTarget(self, action: #selector(deleteQueueBtnClicked(_:)), for: .touchUpInside)
                
                return cell
            }
                
           
        }else if segment3.isSelected {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PendingTVCell.self)) as? PendingTVCell {
                cell.lblAge.text = "\(addQueueListArr[indexPath.row].age) years old"
                cell.lblName.text = "\(addQueueListArr[indexPath.row].last_name) \(addQueueListArr[indexPath.row].first_name)"
                if addQueueListArr[indexPath.row].gender  == 1{
                    cell.lblGender.text = "Male"
                }else if addQueueListArr[indexPath.row].gender  == 2{
                    cell.lblGender.text = "Female"
                }else{
                    cell.lblGender.text = "Others"
                    
                }
                cell.lblDate.text = addQueueListArr[indexPath.row].appoint_date
                cell.lblTime.text = "\(addQueueListArr[indexPath.row].appoint_start_time) - \(addQueueListArr[indexPath.row].appoint_end_time)"

                var sPhotoStr = addQueueListArr[indexPath.row].image
                sPhotoStr = sPhotoStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
                cell.imgProfile.sd_setImage(with: URL(string: sPhotoStr ), placeholderImage:UIImage(named:"placeholderProfileImg"))
                cell.btnAccept.addTarget(self, action: #selector(acceptBtnAction(_:)), for: .touchUpInside)
                cell.btnReject.addTarget(self, action: #selector(rejectBtnAction(_:)), for: .touchUpInside)
                
                return cell
            }
           
        }else if segment4.isSelected{
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentConfirmedTVCell.self)) as? AppointmentConfirmedTVCell {
                cell.lblAge.text = "\(addQueueListArr[indexPath.row].age) years old"
                cell.lblName.text = "\(addQueueListArr[indexPath.row].last_name) \(addQueueListArr[indexPath.row].first_name)"
                if addQueueListArr[indexPath.row].gender  == 1{
                    cell.lblGender.text = "Male"
                }else if addQueueListArr[indexPath.row].gender  == 2{
                    cell.lblGender.text = "Female"
                }else{
                    cell.lblGender.text = "Others"

                }
                cell.lblDate.text = addQueueListArr[indexPath.row].appoint_date
                cell.lblTime.text = "\(addQueueListArr[indexPath.row].appoint_start_time) - \(addQueueListArr[indexPath.row].appoint_end_time)"
                var sPhotoStr = addQueueListArr[indexPath.row].image
                sPhotoStr = sPhotoStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
                cell.imgProfile.sd_setImage(with: URL(string: sPhotoStr ), placeholderImage:UIImage(named:"placeholderProfileImg"))
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if segment3.isSelected{
            return 167
        }else if segment2.isSelected{
            //            if indexPath.row % 2 == 0 || indexPath.row % 3 == 0{
            //                return 160
            //            }else{
            return 83
            //  }
        }else{
            return 160
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segment4.isSelected{
            let controller =  NavigationManager.shared.appointmentDetailVC
            controller.cFirstUserName = addQueueListArr[indexPath.row].first_name 
            controller.cLastUserName = addQueueListArr[indexPath.row].last_name
            controller.cUserAge = addQueueListArr[indexPath.row].age
            controller.cUserImage = addQueueListArr[indexPath.row].image
            controller.cUserGender = addQueueListArr[indexPath.row].gender
            controller.cUserPGName = addQueueListArr[indexPath.row].loginuser_name
        
           
            controller.cDoctorName = addQueueListArr[indexPath.row].description
            controller.cUserAppointmentTime = "\(addQueueListArr[indexPath.row].appoint_start_time) - \(addQueueListArr[indexPath.row].appoint_end_time)"

            controller.cUserAppointmentDate = addQueueListArr[indexPath.row].appoint_date

            push(controller: controller)
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
            lastPageNo = 1
            self.noFoundAppointmentTypeView.isHidden = true
            addQueueListNUArr.removeAll()
            getCPQListApi(statusS: 1)
        }
        else if view == segment3 {
            
            segment1.isSelected = false
            segment2.isSelected = false
            segment4.isSelected = false
            lastPageNo = 1
            addQueueListNUArr.removeAll()
            self.noFoundAppointmentTypeView.isHidden = true

            getCPQListApi(statusS: 2)
        }
        else if view == segment4 {
            segment1.isSelected = false
            segment2.isSelected = false
            segment3.isSelected = false
            lastPageNo = 1
            addQueueListNUArr.removeAll()
            self.noFoundAppointmentTypeView.isHidden = true

            getCPQListApi(statusS: 3)
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
    func generatingARParameters(status:Int,addUserId:Int) -> [String:AnyObject] {
        var parameters:[String:AnyObject] = [:]
        
        parameters["id"] = addUserId as AnyObject
        
        parameters["status"] = status as AnyObject
        
        print(parameters)
        return parameters
    }
    @objc func rejectBtnAction(_ sender: Any?) {
        //        verifiedPUpViewA.isHidden = false
        //        self.verifiedIdentityPopUpView.isHidden = false
        
        let button = sender as? UIButton
        var parentCell = button?.superview
        
        while !(parentCell is UITableViewCell) {
            parentCell = parentCell?.superview
        }
        var indexPath: IndexPath? = nil
        if let cell = parentCell as? UITableViewCell {
            indexPath = tblAppointment.indexPath(for: cell)
        }
        let addUserId = addQueueListArr[indexPath?.row ?? 0].id
        
        
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        ModalResponse().pendingAppointmentAcceptRejectApi(params:generatingARParameters(status:4, addUserId:addUserId)) { response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            let getARData  = ForgotPasswordData(dict:response as? [String : AnyHashable] ?? [:])
            if getARData?.status == 200{
                showAlertMessage(title: kAppName.localized(), message: getARData?.message ?? "" , okButton: "OK", controller: self) {
                    self.lastPageNo = 1
                    self.addQueueListNUArr.removeAll()
                    self.getCPQListApi(statusS: 2)
                }
            }
            else if getARData?.status == 401{
                removeAppDefaults(key:"AuthToken")
                appDel.logOut()
            }
            else{
                alert(AppAlertTitle.appName.rawValue, message: getARData?.message ?? "", view: self)
            }
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
        
    }
    @objc func acceptBtnAction(_ sender: Any?) {
//        verifiedPUpViewA.isHidden = false
//        self.verifiedIdentityPopUpView.isHidden = false
        
        let button = sender as? UIButton
        var parentCell = button?.superview
        
        while !(parentCell is UITableViewCell) {
            parentCell = parentCell?.superview
        }
        var indexPath: IndexPath? = nil
        if let cell = parentCell as? UITableViewCell {
            indexPath = tblAppointment.indexPath(for: cell)
        }
        let addUserId = addQueueListArr[indexPath?.row ?? 0].id
        
        
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        ModalResponse().pendingAppointmentAcceptRejectApi(params:generatingARParameters(status:3, addUserId:addUserId)) { response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            let getARData  = ForgotPasswordData(dict:response as? [String : AnyHashable] ?? [:])
            if getARData?.status == 200{
                //                showAlertMessage(title: kAppName.localized(), message: getARData?.message ?? "" , okButton: "OK", controller: self) {
                self.lastPageNo = 1
                self.addQueueListNUArr.removeAll()
                self.getCPQListApi(statusS: 2)
                // }
            }
            else if getARData?.status == 401{
                removeAppDefaults(key:"AuthToken")
                appDel.logOut()
            }
            else{
                alert(AppAlertTitle.appName.rawValue, message: getARData?.message ?? "", view: self)
            }
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
        
        
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
        
        
        //
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.noFoundAppointmentTypeView.isHidden = true

        setup()
        self.tabBarController?.tabBar.isHidden = false
        lastPageNo = 1
        addQueueListNUArr.removeAll()
        
        getCPQListApi(statusS: 1)
        
        getHospitalListApi()
    }
    
    //------------------------------------------------------
}
extension AppointmentVC:KRPullLoadViewDelegate{
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    completionHandler()
                    if self.segment2.isSelected == true{
                        self.getCPQListApi(statusS: 1)
                    }
                    else if self.segment3.isSelected == true{
                        self.getCPQListApi(statusS: 2)
                        
                    }else if self.segment4.isSelected == true{
                        self.getCPQListApi(statusS: 3)
                        
                    }
                    
                }
            default: break
            }
            return
        }
        
        switch state {
        case .none:
            pullLoadView.messageLabel.text = ""
            
        case let .pulling(offset, threshould):
            if offset.y > threshould {
                pullLoadView.messageLabel.text = "Pull more. offset: \(Int(offset.y)), threshould: \(Int(threshould)))"
            } else {
                pullLoadView.messageLabel.text = "Release to refresh. offset: \(Int(offset.y)), threshould: \(Int(threshould)))"
            }
            
        case let .loading(completionHandler):
            pullLoadView.messageLabel.text = "Updating..."
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                completionHandler()
                if self.segment2.isSelected == true{
                    self.getCPQListApi(statusS: 1)
                }
                else if self.segment3.isSelected == true{
                    self.getCPQListApi(statusS: 2)
                    
                }else if self.segment4.isSelected == true{
                    self.getCPQListApi(statusS: 3)
                    
                }
                
            }
        }
    }
    
    
}

