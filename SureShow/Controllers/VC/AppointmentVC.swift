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
    
    //    let appoitmentCases = AppoitmentListing()
    var needToshowInfoView: Bool = false
    
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
        segment2.isSelected = !segment1.isSelected
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
    
    func updateUI() {
        
        tblAppointment.reloadData()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource,UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segment1.isSelected{
            if indexPath.row % 2 == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentConfirmedTVCell.self)) as? AppointmentConfirmedTVCell {
                    return cell
                }
            }else if indexPath.row % 3 == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PendingTVCell.self)) as? PendingTVCell {
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QueueTVCell.self)) as? QueueTVCell {
                    return cell
                }
            }
        }else if segment2.isSelected {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentConfirmedTVCell.self)) as? AppointmentConfirmedTVCell {
                return cell
            }
        }else if segment3.isSelected {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PendingTVCell.self)) as? PendingTVCell {
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
    
    @IBAction func btnAdd(_ sender: Any) {
        let controller = NavigationManager.shared.addQueueVC
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
    }
    
    //------------------------------------------------------
}
