//
//  EditProfileVC.swift
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

class EditProfileVC : BaseVC, UITextViewDelegate, UITextFieldDelegate, ImagePickerDelegate {
    
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewOtherInfo: UIView!
    @IBOutlet weak var txtOtherInfo: SSBaseTextField!
    @IBOutlet weak var txtPhone: SSMobileNumberTextField!
    @IBOutlet weak var txtEmail: SSEmailTextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFirstName: SSUsernameTextField!
    @IBOutlet weak var txtLastName: SSUsernameTextField!
    var imgArray = [Data]()
    var getProfileResp: GetUserProfileData<Any>?

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
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPhone.delegate = self
        txtOtherInfo.delegate = self
        
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtFirstName.text) == true {

            showAlertMessage(title: kAppName.localized(), message: "Please enter first name." , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        if ValidationManager.shared.isEmpty(text: txtLastName.text) == true {

            showAlertMessage(title: kAppName.localized(), message: "Please enter last name." , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtEmail.text) == true {

            showAlertMessage(title: kAppName.localized(), message: "Please enter email address." , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtPhone.text) == true {

            showAlertMessage(title: kAppName.localized(), message: "Please enter mobile number." , okButton: "Ok", controller: self) {
                
            }
            return false
        }
//        if ValidationManager.shared.isEmpty(text: txtOtherInfo.text) == true {
//            showAlertMessage(title: kAppName.localized(), message: "Please enter relation to patient" , okButton: "Ok", controller: self) {
//
//            }
//            return false
//        }
        
        return true
    }
    
    func editProfileApi() {
        let compressedData = (imgProfile.image?.jpegData(compressionQuality: 0.3))!
        imgArray.removeAll()
        
        imgArray.append(compressedData)
        
        let paramds = ["first_name":txtFirstName.text ?? "" ,"last_name":txtLastName.text ?? "","email":txtEmail.text ?? "","cellno":txtPhone.text ?? ""] as [String : Any]
        
        let strURL = kBASEURL + WSMethods.editProfile
        
        self.requestWith(endUrl: strURL , parameters: paramds)
        
        
    }
    func requestWith(endUrl: String, parameters: [AnyHashable : Any]){
        
        let url = endUrl /* your API url */
        var authToken = getSAppDefault(key: "AuthToken") as? String ?? ""
//        let headers: HTTPHeaders = [
//            .authorization(bearerToken: authToken)]
        authToken = "Bearer " + authToken
        let headers : HTTPHeaders = ["Content-Type":"application/json" , "Authorization":authToken ]
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
                let signUpStepData =  ForgotPasswordData(dict: respDict)
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
    
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
    }
    
    @IBAction func btnProfileImg(_ sender: Any) {
        self.imagePickerVC?.present(from: (sender as? UIView)!)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if validate() == false {
            return
        }
        else{
            editProfileApi()
        }
       
    }
    
    //------------------------------------------------------
    
    //MARK: SSImagePickerDelegate
    
    func didSelect(image: UIImage?) {
        if let imageData = image?.jpegData(compressionQuality: 0), let compressImage = UIImage(data: imageData) {
            self.selectedImage = Toucan.init(image: compressImage).resizeByCropping(SSSettings.profileImageSize).maskWithRoundedRect(cornerRadius: SSSettings.profileImageSize.width/2, borderWidth: SSSettings.profileBorderWidth, borderColor: UIColor.white).image
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
        switch textField {
        case txtEmail:
            viewEmail.borderColor =  SSColor.appButton
        case txtFirstName:
            viewFirstName.borderColor =  SSColor.appButton
        case txtLastName:
            viewLastName.borderColor =  SSColor.appButton
        case txtPhone:
            viewPhone.borderColor =  SSColor.appButton
        case txtOtherInfo:
            viewOtherInfo.borderColor =  SSColor.appButton
        default:break
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case txtEmail:
            viewEmail.borderColor = SSColor.appBlack
        case txtFirstName:
            viewFirstName.borderColor = SSColor.appBlack
        case txtLastName:
            viewLastName.borderColor = SSColor.appBlack
        case txtPhone:
            viewPhone.borderColor = SSColor.appBlack
        case txtOtherInfo:
            viewOtherInfo.borderColor = SSColor.appBlack
        default:break
        }
    }
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtFirstName.text = getProfileResp?.first_name
        txtLastName.text = getProfileResp?.last_name
        txtEmail.text = getProfileResp?.email
        txtPhone.text = getProfileResp?.cellno
        var sPhotoStr = getProfileResp?.image
        sPhotoStr = sPhotoStr?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        //        if sPhotoStr != ""{
        imgProfile.sd_setImage(with: URL(string: sPhotoStr ?? ""), placeholderImage:UIImage(named:"place"))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imgProfile.circle()
    }
    
    //------------------------------------------------------
}
