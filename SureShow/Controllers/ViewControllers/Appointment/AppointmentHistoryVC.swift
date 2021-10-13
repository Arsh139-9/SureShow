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
    
    func setup() {
        tblAppointment.delegate = self
        tblAppointment.dataSource = self
        
       
        
        let identifier = String(describing: AppointmentHistoryTVCell.self)
        let nibCell = UINib(nibName: identifier, bundle: Bundle.main)
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
                if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AppointmentHistoryTVCell.self)) as? AppointmentHistoryTVCell {
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
    }
    
    //------------------------------------------------------
}
    

   


