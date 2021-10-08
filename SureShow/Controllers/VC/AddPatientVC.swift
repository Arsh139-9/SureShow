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
    @IBOutlet weak var viewGender: UIView!
    @IBOutlet weak var txtBirth: SSBirthDateTextField!
    @IBOutlet weak var viewBirthDate: UIView!
    @IBOutlet weak var txtName: SSUsernameTextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var unchKRBtn: UIButton!
    
    @IBOutlet weak var cHKRBtn: UIButton!
    
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
        
        if ValidationManager.shared.isEmpty(text: txtGender.text) == true {
            showAlertMessage(title: kAppName.localized(), message: "Please select Gender" , okButton: "Ok", controller: self) {
                
            }
            return false
        }
        
        return true
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    @IBAction func unchekRadioBtnAction(_ sender: UIButton) {
//        inventoryCount = "2"
        unchKRBtn.setImage(UIImage(named: "sel"), for:UIControl.State.normal)
        cHKRBtn.setImage(UIImage(named: "un"), for:UIControl.State.normal)
    }
    
    @IBAction func chckRadioBtnAction(_ sender: UIButton) {
//        inventoryCount = "1"
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
        validate()
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

        if textField == txtName {
            viewName.borderColor = SSColor.appButton
            
        } else if textField == txtBirth {
            txtBirth.borderColor = SSColor.appButton
        }else if textField == txtGender{
            txtGender.borderColor = SSColor.appButton
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
