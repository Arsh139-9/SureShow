//
//  NotificationVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//
import UIKit
import Foundation
import Alamofire
import KRPullLoader

class NotificationVC: UIViewController {
    
    var lastPageNo = 1
    
    @IBOutlet weak var tblNotification: UITableView!
    
    var notificationListArr = [NotificationListData<AnyHashable>]()
    var notificationNUArray = [NotificationListData<AnyHashable>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNotification.dataSource = self
        tblNotification.delegate = self
        
        tblNotification.register(UINib(nibName: "NotificationTVCell", bundle: nil), forCellReuseIdentifier: "NotificationTVCell")
        
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tblNotification.addPullLoadableView(loadMoreView, type: .loadMore)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lastPageNo = 1
        getNotificationListApi()
        
    }
    func updateUI() {
        
        // Add the video preview layer to the view
        //        self.tabBarController?.tabBar.isHidden = false
        
        tblNotification.reloadData()
    }
   
    open func getNotificationListApi(){
        
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        ModalResponse().getNotificationListApi(perPage:9, page: lastPageNo){ response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            
            let getNotificationDataResp  = GetNotificationListData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getNotificationDataResp?.message ?? ""
            if let status = getNotificationDataResp?.status{
                if status == 200{
                    self.lastPageNo = self.lastPageNo + 1
                    let notificationArr = getNotificationDataResp?.notificationListArray ?? []
                    
                    if notificationArr.count != 0{
                        DispatchQueue.main.async {
                            //                            self.noDataFoundView.isHidden = true
                        }
                        for i in 0..<notificationArr.count {
                            self.notificationNUArray.append(notificationArr[i])
                        }
                        self.notificationNUArray.sort {
                            $0.creation_date > $1.creation_date
                        }
                        let uniquePosts = self.notificationNUArray.unique{$0.id }
                        
                        self.notificationListArr = uniquePosts
                        
                        
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
                    
                    alert(AppAlertTitle.appName.rawValue, message: message, view: self)
                }
            }
            
        } onFailure: { error in
            AFWrapperClass.svprogressHudDismiss(view: self)
            alert(AppAlertTitle.appName.rawValue, message: error.localizedDescription, view: self)
        }
    }
    
}
extension NotificationVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVCell", for: indexPath) as! NotificationTVCell
        let notify = notificationListArr[indexPath.row]
        var sPhotoStr = notificationListArr[indexPath.row].image
        sPhotoStr = sPhotoStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        cell.imgProfile.sd_setImage(with: URL(string: sPhotoStr ), placeholderImage:UIImage(named:"placeholderProfileImg"))
        cell.lblDetails.text = notify.notify_title
        cell.lblTime.text = notify.creation_date == "" ? "11:30 AM":notify.creation_date
        cell.lblDate.text = notify.appoint_start_time == "" ? "5-12-2021, 12:00 PM to 02:00 Pm":notify.appoint_start_time
        //        cell.viewAccept.isHidden = true
        //        if indexPath.row == 0{
        //            cell.viewAccept.isHidden = false
        //        }else if indexPath.row == 1{
        //            cell.viewAccept.isHidden = true
        //        }else if indexPath.row == 2{
        //            cell.viewAccept.isHidden = false
        //        }else{}
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension NotificationVC:KRPullLoadViewDelegate{
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    completionHandler()
                    
                    self.getNotificationListApi()
                    
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
                self.getNotificationListApi()
                
            }
        }
    }
    
    
}

