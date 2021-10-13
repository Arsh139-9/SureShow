//
//  AddPatientVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 20/09/21.
//

import UIKit
import Toucan
import SDWebImage
import Foundation
import Alamofire
import IQKeyboardManagerSwift

class AddPatientVC : BaseVC, UITextViewDelegate, UITextFieldDelegate, ImagePickerDelegate {
    
    @IBOutlet weak var txtGender: SSGenderTextField!
    
    @IBOutlet weak var txtUserRelationship: SSRelationshipTextField!
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var txtBirth: SSBirthDateTextField!
    @IBOutlet weak var viewBirthDate: UIView!
    @IBOutlet weak var txtName: SSUsernameTextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var unchKRBtn: UIButton!
    
    @IBOutlet weak var cHKRBtn: UIButton!
    var imgArray = [Data]()
    var childAdultStatus = String()
    var relationshipListArr = [RelationshipListData<AnyHashable>]()

    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    var imagePickerVC: ImagePicker?
    var selectedImage: UIImage? {
        didSet {
            if selectedImage != nil {
                imgProfile.image = selectedImage
            }
        }
    }
    
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
        //        imgProfile.image = getPlaceholderImage()
        imagePickerVC = ImagePicker(presentationController: self, delegate: self)
        
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        
        txtName.delegate = self
        txtBirth.delegate = self
        txtGender.delegate = self
        txtUserRelationship.delegate = self
        txtUserRelationship.relationshipListArr = relationshipListArr
        
        childAdultStatus = "2"
        
    }
    func genderValParamUpdate() -> String{
        if txtGender.text == "Male"{
            return "1"
        }else{
            return "2"
        }
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtName.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please enter name." , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        if ValidationManager.shared.isEmpty(text: txtBirth.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select Date of Birth" , okButton: "Ok", controller: self) {
                
            }
            return false
        }
//        if ValidationManager.shared.isEmpty(text: childAdultStatus) == true {
//            showAlertMessage(title: kAppName.localized(), message: "Please select either child or adult" , okButton: "Ok", controller: self) {
//                
//            }
//            return false
//        }
        if ValidationManager.shared.isEmpty(text: txtGender.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select Gender" , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        if ValidationManager.shared.isEmpty(text: txtUserRelationship.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select Relation" , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        
        return true
    }
    func addUserApi() {
        let compressedData = (imgProfile.image?.jpegData(compressionQuality: 0.3))!
        imgArray.removeAll()
        if compressedData.isEmpty == false{
            imgArray.append(compressedData)
        }
        //        parameters["cellno"] = "\(getSAppDefault(key: "countryName") as? String ?? "")-\(txtPhoneNum.text ?? "")" as AnyObject
        //,"type":"1"
        let paramds = ["name":txtName.text ?? "" ,"dob":txtBirth.text ?? "","gender":genderValParamUpdate(),"type":childAdultStatus] as [String : Any]
        
        let strURL = kBASEURL + WSMethods.addPatient
        
        self.requestWith(endUrl: strURL , parameters: paramds)
        
        
    }
    func requestWith(endUrl: String, parameters: [AnyHashable : Any]){
        
        let url = endUrl /* your API url */
        var authToken = getSAppDefault(key: "AuthToken") as? String ?? ""
        //        let headers: HTTPHeaders = [
        //            .authorization(bearerToken: authToken)]
        authToken = "Bearer " + authToken
        let headers : HTTPHeaders = ["Content-Type":"application/json" , "Authorization":authToken]
        //        let headers: HTTPHeaders = [
        //            /* "Authorization": "your_access_token",  in case you need authorization header */
        //            "Content-type": "multipart/form-data",
        //            "Authorization": "Bearer " + authToken,
        //        ]
        DispatchQueue.main.async {
            
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as! String)
            }
            
            
            for i in 0..<self.imgArray.count{
                let imageData1 = self.imgArray[i]
                debugPrint("mime type is\(imageData1.mimeType)")
                let ranStr = String.random(length: 7)
                if imageData1.mimeType == "application/pdf" ||
                    imageData1.mimeType == "application/vnd" ||
                    imageData1.mimeType == "text/plain"{
                    multipartFormData.append(imageData1, withName: "image[\(i + 1)]" , fileName: ranStr + String(i + 1) + ".pdf", mimeType: imageData1.mimeType)
                }else{
                    multipartFormData.append(imageData1, withName: "image" , fileName: ranStr + String(i + 1) + ".jpg", mimeType: imageData1.mimeType)
                }
                
                
                
            }
            
            
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers, interceptor: nil, fileManager: .default)
        
        .uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
            
        })
        .responseJSON { (response) in
            DispatchQueue.main.async {
                
                AFWrapperClass.svprogressHudDismiss(view: self)
            }
            
            print("Succesfully uploaded\(response)")
            let respDict =  response.value as? [String : AnyObject] ?? [:]
            if respDict.count != 0{
                let signUpStepData =  AddUserListData(dict: respDict)
                if signUpStepData?.status == 200{
                    showAlertMessage(title: kAppName.localized(), message: signUpStepData?.message ?? ""  , okButton: "OK", controller: self) {
                        self.navigationController?.popViewController(animated: true)
                        
                        //                        removeAppDefaults(key:"AuthToken")
                        //                        appDel.logOut()
                    }
                }else{
                    
                }
            }else{
                
            }
            
            
        }
        
        
        
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    @IBAction func unchekRadioBtnAction(_ sender: UIButton) {
        childAdultStatus = "1"
        unchKRBtn.setImage(UIImage(named: "sel"), for:UIControl.State.normal)
        cHKRBtn.setImage(UIImage(named: "un"), for:UIControl.State.normal)
    }
    
    @IBAction func chckRadioBtnAction(_ sender: UIButton) {
        childAdultStatus = "2"
        unchKRBtn.setImage(UIImage(named: "un"), for:UIControl.State.normal)
        cHKRBtn.setImage(UIImage(named: "sel"), for:UIControl.State.normal)
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
    }
    
    @IBAction func btnProfile(_ sender: Any) {
        self.imagePickerVC?.present(from: (sender as? UIView)!)
    }
    @IBAction func btnSave(_ sender: Any) {
        if validate() == false {
            return
        }
        else{
            addUserApi()
        }
        
    }
    
    //------------------------------------------------------
    
    //MARK: SSImagePickerDelegate
    
    func didSelect(image: UIImage?) {
        if let imageData = image?.jpegData(compressionQuality: 0), let compressImage = UIImage(data: imageData) {
            //SSSettings.profileImageSize.width/2
            self.selectedImage = Toucan.init(image: compressImage).resizeByCropping(SSSettings.profileImageSize).maskWithRoundedRect(cornerRadius: 8, borderWidth: SSSettings.profileBorderWidth, borderColor: UIColor.white).image
            imgProfile.image = selectedImage
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if IQKeyboardManager.shared.canGoNext {
            IQKeyboardManager.shared.goNext()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == txtName {
            viewName.borderColor = SSColor.appButton
            
        } else if textField == txtBirth {
            txtBirth.borderColor = SSColor.appButton
        }else if textField == txtGender{
            txtGender.borderColor = SSColor.appButton
        }else if textField == txtUserRelationship{
            txtUserRelationship.borderColor = SSColor.appButton
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txtName {
            viewName.borderColor = SSColor.appBlack
        } else if textField == txtBirth {
            txtBirth.borderColor = SSColor.appBlack
        }else if textField == txtGender{
            txtGender.borderColor = SSColor.appBlack
        }
        else if textField == txtUserRelationship{
            txtUserRelationship.borderColor = SSColor.appBlack
        }
    }
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgProfile.circle()
    }
    
    //------------------------------------------------------
}
