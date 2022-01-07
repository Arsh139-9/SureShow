//
//  EditPatientDetailVC.swift
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

class EditPatientDetailVC : BaseVC, UITextViewDelegate, UITextFieldDelegate, ImagePickerDelegate {
    
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var txtFirstName: SSUsernameTextField!
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var txtLastName: SSUsernameTextField!
    @IBOutlet weak var txtBirthDate: SSBirthDateTextField!
    @IBOutlet weak var viewBirthDate: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtGender: SSGenderTextField!
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var txtUserRelationship: SSRelationshipTextField!
    @IBOutlet weak var viewUserRelationship: UIView!
    @IBOutlet weak var unchKRBtn: UIButton!
    @IBOutlet weak var cHKRBtn: UIButton!
    var childAdultStatus:Int?

    var imgArray = [Data]()
    var relationIndex:Int?
    var id:Int?
    var type:Int?
    var userName:String?
    var firstName:String?
    var lastName:String?
    var userAge:String?
    var userImage:String?
    var userGender:Int?
    var relationshipListArr = [RelationshipListData<AnyHashable>]()
    var pvOptionArr = [String]()
    var relationShipId:Int?
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
    
    func selectAdult(){
        unchKRBtn.setImage(UIImage(named: "un"), for:UIControl.State.normal)
        cHKRBtn.setImage(UIImage(named: "sel"), for:UIControl.State.normal)
    }
    func selectChild(){
        unchKRBtn.setImage(UIImage(named: "sel"), for:UIControl.State.normal)
        cHKRBtn.setImage(UIImage(named: "un"), for:UIControl.State.normal)
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        childAdultStatus = type
        imagePickerVC = ImagePicker(presentationController: self, delegate: self)
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        
       
        
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtGender.delegate = self
        txtBirthDate.delegate = self
        txtUserRelationship.delegate = self
        childAdultStatus == 1 ? selectAdult() : selectChild()
        txtFirstName.text = firstName
        txtLastName.text = lastName
        if userGender == 1{
            txtGender.text = "Male"
        }else if userGender == 2{
            txtGender.text = "Female"
        }else{
            txtGender.text = "Others"

        }
        txtBirthDate.text = userAge
        userImage = userImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        //        if sPhotoStr != ""{
        self.imgProfile.sd_setImage(with: URL(string: userImage ?? ""), placeholderImage:UIImage(named:"placeholderProfileImg"))
        txtUserRelationship.delegate = self
        pvOptionArr.removeAll()
        for obj in relationshipListArr {
            pvOptionArr.append(obj.relationship_name)
        }
        for obj in relationshipListArr {
            if obj.id == relationShipId{
                txtUserRelationship.text = obj.relationship_name
               
                break
            }
        }
        if let index = txtGender.pvOptions.firstIndex(where: { $0 == txtGender.text }) {
            txtGender.isFromEdit = true
            txtGender.selectedIndex = index
            txtGender.pvGender.selectRow(index, inComponent: 0, animated: false)
            
        }
        if let index = relationshipListArr.firstIndex(where: { $0.id == relationShipId ?? 0 }) {
            txtUserRelationship.isFromEdit = true
            txtUserRelationship.selectedIndex = index
            txtUserRelationship.pvOptions = pvOptionArr
            txtUserRelationship.pvGender.selectRow(index, inComponent: 0, animated: false)
            relationIndex = index
        }

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
        if ValidationManager.shared.isEmpty(text: txtBirthDate.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select Date of Birth" , okButton: "Ok", controller: self) {
            }
            return false
            
        }
        
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
    
    func genderValParamUpdate() -> String{
        if txtGender.text == "Male"{
            return "1"
        }
        else if txtGender.text == "Female"{
            return "2"
        }
        else{
            return "3"
        }
    }
    func generatingParameters() -> [String:AnyObject] {
        var parameters:[String:AnyObject] = [:]
        
        parameters["id"] = id as AnyObject
        
        
        print(parameters)
        return parameters
    }
    open func deleteUserApi(){
        DispatchQueue.main.async {
            AFWrapperClass.svprogressHudShow(title:"Loading...", view:self)
        }
        let authToken  = getSAppDefault(key: "AuthToken") as? String ?? ""
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: authToken)]
        AFWrapperClass.requestPostWithMultiFormData(kBASEURL + WSMethods.deleteUser, params: generatingParameters(), headers: headers) { response in
            AFWrapperClass.svprogressHudDismiss(view: self)
            print(response)
            let message = response["message"] as? String ?? ""
            if let status = response["status"] as? Int {
                if status == 200{
                    showAlertMessage(title: kAppName.localized(), message: message , okButton: "OK", controller: self) {
                        self.popBack(3)
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
    
    func editUserDetailApi() {
        let compressedData = (imgProfile.image?.jpegData(compressionQuality: 0.3))!
        imgArray.removeAll()
        if compressedData.isEmpty == false{
            imgArray.append(compressedData)
        }
        
        for obj in relationshipListArr {
            if obj.relationship_name == txtUserRelationship.text{
                relationShipId = obj.id
                break
            }
        }
        
        let paramds = ["id":id ?? 0,"first_name":txtFirstName.text ?? "" ,"last_name":txtLastName.text ?? "","dob":txtBirthDate.text ?? "","gender":genderValParamUpdate(),"relationship":"\(relationShipId ?? 0)","type":childAdultStatus ?? 0] as [String : Any]
        
        let strURL = kBASEURL + WSMethods.editUserDetail
        
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
                        self.popBack(3)

                        
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
    
    //MARK: Action
    
    @IBAction func unchekRadioBtnAction(_ sender: UIButton) {
        childAdultStatus = 2
        selectChild()

    }
    
    @IBAction func chckRadioBtnAction(_ sender: UIButton) {
        childAdultStatus = 1
        selectAdult()

    }
    
    @IBAction func btnSave(_ sender: Any) {
        if validate() == false {
            return
        }
        else{
            editUserDetailApi()
        }
        
    }
    
    @IBAction func btnProfile(_ sender: Any) {
        self.imagePickerVC?.present(from: (sender as? UIView)!)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        
        deleteUserApi()
    }
    
    //------------------------------------------------------
    
    //MARK: SSImagePickerDelegate
    
    func didSelect(image: UIImage?) {
        if let imageData = image?.jpegData(compressionQuality: 0), let compressImage = UIImage(data: imageData) {
            //SSSettings.profileImageSize.width/2
            self.selectedImage = Toucan.init(image: compressImage).resizeByCropping(SSSettings.profileImageSize).maskWithRoundedRect(cornerRadius:8 , borderWidth: SSSettings.profileBorderWidth, borderColor: UIColor.white).image
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
        case txtFirstName:
            viewFirstName.borderColor =  SSColor.appButton
        case txtLastName:
            viewLastName.borderColor =  SSColor.appButton
        case txtBirthDate:
            viewBirthDate.borderColor =  SSColor.appButton
        case txtGender:
            viewGender.borderColor =  SSColor.appButton
        case txtUserRelationship:
            viewUserRelationship.borderColor =  SSColor.appButton
        default:break
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        
        case txtFirstName:
            viewFirstName.borderColor =  SSColor.appBlack
        case txtLastName:
            viewLastName.borderColor =  SSColor.appBlack
        case txtBirthDate:
            viewBirthDate.borderColor =  SSColor.appBlack
        case txtGender:
            viewGender.borderColor =  SSColor.appBlack
        case txtUserRelationship:
            viewUserRelationship.borderColor =  SSColor.appButton
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgProfile.setRounded()
    }
    
    //------------------------------------------------------
}
