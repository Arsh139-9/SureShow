//
//  AppointmentHistoryVC.swift
//  SureShow
//
//  Created by Apple on 07/10/21.
//

import UIKit

class AppointmentHistoryVC: BaseVC,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tblAppointment: UITableView!

    //MARK: Customs
    var appointmentHistoryListArr:[AddQueueListData<AnyHashable>]?
    var lastPageNo:Int?

    func setup() {
        tblAppointment.delegate = self
        tblAppointment.dataSource = self
        
       
        
        let identifier = String(describing: AppointmentHistoryTVCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblAppointment.register(nibCell, forCellReuseIdentifier: identifier)
        
    
        
        updateUI()
        
    }
    open func getAppointmentHistoryListsApi(){
        
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        ModalResponse().getAppointmentHistoryListApi(perPage:9, page: lastPageNo ?? 0){ response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            
            let getAppointmentDataResp  = GetAddQueueData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getAppointmentDataResp?.message ?? ""
            if let status = getAppointmentDataResp?.status{
                if status == 200{
                    self.lastPageNo = self.lastPageNo ?? 0 + 1
                    let getAppointmentListArr = getAppointmentDataResp?.addQueueListArray ?? []
                    
                    if getAppointmentListArr.count != 0{
                        DispatchQueue.main.async {
                            //                            self.noDataFoundView.isHidden = true
                        }
                        var addAppointmentListNUArr = [AddQueueListData<AnyHashable>]()
                        
                        for i in 0..<getAppointmentListArr.count {
                            addAppointmentListNUArr.append(getAppointmentListArr[i])
                        }
                        addAppointmentListNUArr.sort {
                            $0.id > $1.id
                        }
                        let uniquePosts = addAppointmentListNUArr.unique{$0.id }
                        
                        self.appointmentHistoryListArr = uniquePosts
                        
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
                }else{
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                    
                }
                
            }
            
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
    }
    func updateUI() {
        
        tblAppointment.reloadData()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource,UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointmentHistoryListArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentHistoryTVCell.self)) as? AppointmentHistoryTVCell {
                    cell.lblAge.text = "\(appointmentHistoryListArr?[indexPath.row].age ?? 0) years old"
                    cell.lblName.text = "\(appointmentHistoryListArr?[indexPath.row].last_name ?? "") \(appointmentHistoryListArr?[indexPath.row].first_name ?? "")"
                    if appointmentHistoryListArr?[indexPath.row].gender  == 1{
                        cell.lblGender.text = "Male"
                    }else if appointmentHistoryListArr?[indexPath.row].gender  == 2{
                        cell.lblGender.text = "Female"
                    }else{
                        cell.lblGender.text = "Others"

                    }
                    cell.appointmentHistoryDate.text = appointmentHistoryListArr?[indexPath.row].appoint_date
                    cell.lblTime.text =  appointmentHistoryListArr?[indexPath.row].appoint_start_time ?? "" != "" && appointmentHistoryListArr?[indexPath.row].appoint_end_time ?? "" != "" ? "\(returnFirstWordInString(string:appointmentHistoryListArr?[indexPath.row].appoint_start_time ?? ""))\(getAMPMFromTime(time: Int(appointmentHistoryListArr?[indexPath.row].appoint_start_time ?? "") ?? 0)) - \(returnFirstWordInString(string:appointmentHistoryListArr?[indexPath.row].appoint_end_time ?? ""))\(getAMPMFromTime(time:  Int(appointmentHistoryListArr?[indexPath.row].appoint_end_time ?? "") ?? 0))" : ""
                    var sPhotoStr = appointmentHistoryListArr?[indexPath.row].image
                    sPhotoStr = sPhotoStr?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
                    cell.imgProfile.sd_setImage(with: URL(string: sPhotoStr ?? "" ), placeholderImage:UIImage(named:"placeholderProfileImg"))
                    return cell
                }
    
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 160
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let controller =  NavigationManager.shared.appointmentDetailVC
            push(controller: controller)
      
    }
    
    //------------------------------------------------------
    
   
    //MARK: Action
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        lastPageNo = 1
        getAppointmentHistoryListsApi()
    }
    
    //------------------------------------------------------
}
    

   


