//
//  HomeVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit
import Foundation
import Alamofire

class HomeVC: UIViewController {
    
    @IBOutlet weak var tblHome: UITableView!
    var HomeArray = [HomeData]()
    var homeUserListArr = [UserListData<AnyHashable>]()
    var relationshipListArr = [RelationshipListData<AnyHashable>]()
    lazy var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblHome.dataSource = self
        tblHome.delegate = self
        
        tblHome.register(UINib(nibName: "HomeTVCell", bundle: nil), forCellReuseIdentifier: "HomeTVCell")
        self.HomeArray.append(HomeData(image: "uncle", name: "Grave Judson", gender: "Male" ,  age: "75 years old"))
        self.HomeArray.append(HomeData(image: "uncle", name: "Harry Judson", gender: "Male" ,  age: "65 years old"))
        self.HomeArray.append(HomeData(image: "uncle", name: "Peter Grave ", gender: "Male" ,  age: "70 years old"))
        self.HomeArray.append(HomeData(image: "uncle", name: "Bithr pop", gender: "Male" ,  age: "55 years old"))
        self.HomeArray.append(HomeData(image: "uncle", name: "Grave Judson", gender: "Male" ,  age: "70 years old"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            self.getUserListDataApi()
            self.getRelationshipListApi()
        
        
    }
    
    func generatingParameters() -> [String:AnyObject] {
        var parameters:[String:AnyObject] = [:]
        
        parameters["usertype"] = "1"  as AnyObject
        
        //        parameters["device_type"] = "1"  as AnyObject
        //        var deviceToken  = getSAppDefault(key: "DeviceToken") as? String ?? ""
        //        if deviceToken == ""{
        //            deviceToken = "123"
        //        }
        //        parameters["device_token"] = deviceToken  as AnyObject
        print(parameters)
        return parameters
    }
    open func getRelationshipListApi(){
        ModalResponse().getRelationshipListApi(){ response in
            print(response)
            let getHomeListDataResp  = GetRelationshipData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getHomeListDataResp?.message ?? ""
            if let status = getHomeListDataResp?.status{
                if status == 200{
                    self.relationshipListArr = getHomeListDataResp?.relationshipListArray ?? []
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
    open func getUserListDataApi(){
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        AFWrapperClass.requestGETURL(kBASEURL + WSMethods.getUserList, params:nil, headers: headers) { response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            let getHomeListDataResp  = GetHomeUserListData(dict:response as? [String : AnyHashable] ?? [:])
            let message = getHomeListDataResp?.message ?? ""
            
            if let status = getHomeListDataResp?.status{
                if status == 200{
                    self.homeUserListArr = getHomeListDataResp?.homeUserListArray ?? []
                    DispatchQueue.main.async {
                        self.tblHome.reloadData()
                    }
                    //                    showAlertMessage(title: kAppName.localized(), message: message , okButton: "OK", controller: self) {
                    //
                    //                    }
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
    @IBAction func btnAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name:StoryboardName.HomeChild, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPatientVC") as! AddPatientVC
        vc.relationshipListArr = relationshipListArr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeUserListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
        var sPhotoStr = homeUserListArr[indexPath.row].image
        sPhotoStr = sPhotoStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        cell.imgProfile.sd_setImage(with: URL(string: sPhotoStr ), placeholderImage:UIImage(named:"placeholderProfileImg"))
        let birthday = dateFormatter.date(from: homeUserListArr[indexPath.row].dob)
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        cell.lblAge.text = "\(age) years old"
        cell.lblName.text = homeUserListArr[indexPath.row].name
        if homeUserListArr[indexPath.row].gender  == 1{
            cell.lblGender.text = "Male"
        }else{
            cell.lblGender.text = "Female"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:StoryboardName.HomeChild, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PatientDetailVC") as! PatientDetailVC
        vc.userName = homeUserListArr[indexPath.row].name
        vc.userAge = homeUserListArr[indexPath.row].dob
        vc.userImage = homeUserListArr[indexPath.row].image
        vc.id = homeUserListArr[indexPath.row].id
        if homeUserListArr[indexPath.row].gender  == 1{
            vc.userGender = "Male"
        }else{
            vc.userGender = "Female"
        }
        vc.parentGuardianName = homeUserListArr[indexPath.row].loginusername
        vc.appointmentDate = ""
        vc.appointmentTime = ""
        vc.relationShipId = homeUserListArr[indexPath.row].relationship
        vc.relationshipListArr = relationshipListArr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

struct HomeData {
    var image : String
    var name : String
    var gender : String
    var age : String
    
    init(image : String, name : String , gender : String, age : String ) {
        self.image = image
        self.name = name
        self.gender = gender
        self.age = age
        
        
    }
}
