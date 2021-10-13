//
//  NotificationVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//
import UIKit
import Foundation
import Alamofire

class NotificationVC: UIViewController {
    
    
    @IBOutlet weak var tblNotification: UITableView!
    
    var NotificationsArray = [NotificationsData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNotification.dataSource = self
        tblNotification.delegate = self
        
        tblNotification.register(UINib(nibName: "NotificationTVCell", bundle: nil), forCellReuseIdentifier: "NotificationTVCell")
        
        self.NotificationsArray.append(NotificationsData(image: "uncle", details: "Grave Jodson accepted your appointment schedule on  Grave Jodson accepted your appointment schedule on", time : "11:35 AM", appointmentTime: "5-12-2021, 12:00 PM to 02:00 PM",selected: true))
        self.NotificationsArray.append(NotificationsData(image: "uncle", details: "Grave Jodson accepted your appointment schedule on", time : "11:35 AM", appointmentTime: "5-12-2021, 12:00 PM to 02:00 PM",selected: false))
        self.NotificationsArray.append(NotificationsData(image: "uncle", details: "Grave Jodson accepted your appointment schedule on", time : "11:35 AM", appointmentTime: "5-12-2021, 12:00 PM to 02:00 PM", selected: true))
        
    }
    
}
extension NotificationVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVCell", for: indexPath) as! NotificationTVCell
        let notify = NotificationsArray[indexPath.row]
        cell.imgProfile.image = UIImage(named: NotificationsArray[indexPath.row].image)
        cell.lblDetails.text = notify.details
        cell.lblTime.text = notify.time
        cell.lblDate.text = notify.appointmentTime
        if indexPath.row == 0{
            cell.viewAccept.isHidden = false
        }else if indexPath.row == 1{
            cell.viewAccept.isHidden = true
        }else if indexPath.row == 2{
            cell.viewAccept.isHidden = false
        }else{}
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
struct NotificationsData {
    var image : String
    var details : String
    var time : String
    var appointmentTime : String
    var selected : Bool
    init(image : String, details : String , time : String, appointmentTime : String, selected : Bool ) {
        self.image = image
        self.details = details
        self.time = time
        self.appointmentTime = appointmentTime
        self.selected = selected
        
    }
}
