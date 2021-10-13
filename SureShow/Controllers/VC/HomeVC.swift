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
    
    @IBAction func btnAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name:StoryboardName.HomeChild, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPatientVC") as! AddPatientVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVCell", for: indexPath) as! HomeTVCell
        cell.imgProfile.image = UIImage(named: HomeArray[indexPath.row].image)
        cell.lblAge.text = HomeArray[indexPath.row].age
        cell.lblName.text = HomeArray[indexPath.row].name
        cell.lblGender.text = HomeArray[indexPath.row].gender
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:StoryboardName.HomeChild, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PatientDetailVC") as! PatientDetailVC
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
