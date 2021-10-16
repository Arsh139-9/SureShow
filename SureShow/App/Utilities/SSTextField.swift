//
//  PMTextField.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import Foundation
import UIKit
import Toucan
import MonthYearPicker


protocol UploadImages {
    func pickImage (tag : Int)
}
protocol SelectedDateProtocal {
    func selectedDate (date : Date)
}

public var todaysDate = Date()
public var selectedDatess = Date()
public var selectedDatesssssss = Date()

class SSBaseTextField: UITextField {

    var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    var fontSize : CGFloat = 0.0
    
    public var padding: Double = 8
    
    private var leftEmptyView: UIView {
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: padding, height: Double.zero)))
    }
    
    private var leftButton : UIButton {
        return UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: padding, height: Double.zero)))
    }


    private var rightEmptyViewForButton : UIView {
        return leftButton
    }
    
    private var rightEmptyView: UIView {
        return leftEmptyView
    }
    
    override func becomeFirstResponder() -> Bool {
        HighlightLayer()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        resetLayer()
        return super.resignFirstResponder()
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    fileprivate func setupDefault() {
        
        self.cornerRadius = SSSettings.cornerRadius
        self.borderWidth = SSSettings.borderWidth
        self.borderColor = SSColor.appButton
        self.shadowColor = SSColor.appWhite
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = SSSettings.shadowOpacity
        self.tintColor = SSColor.appWhite
        self.textColor = SSColor.appWhite
    }
    fileprivate func HighlightLayer() {
        self.borderColor = SSColor.appButton
        self.tintColor = SSColor.appButton
    }
    
    fileprivate func resetLayer() {
        self.borderColor = SSColor.appBlack
        self.tintColor = SSColor.appBlack
    }

    private func setup() {
        
        fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
        
        leftView = leftEmptyView
        leftViewMode = .always
        
        rightView = rightEmptyView
        rightViewMode = .always
        
        setupDefault()
    }
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
       fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
    }
}
class SSProDisplayRegularTextField: SSBaseTextField {

    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SSFont.PoppinsRegular(size: fontSize)
    }
}


    
    class SSProDisplaySemiBoldTextField: SSBaseTextField {

        /// common text field layout for inputs
        ///
        /// - Parameter aDecoder: aDecoder description
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
            self.font = SSFont.PoppinsSemiBold(size: fontSize)
        }
    }
    class SSRegularTextField: SSBaseTextField {
        
        /// common text field layout for inputs
        ///
        /// - Parameter aDecoder: aDecoder description
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
            self.font = SSFont.PoppinsRegular(size: fontSize)
        }
    }
class SSMediumTextField: SSBaseTextField {
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SSFont.PoppinsMedium(size: fontSize)
    }
}
class SSSemiboldTextField: SSBaseTextField {
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SSFont.PoppinsSemiBold(size: fontSize)
    }
}

class SSEmailTextField: SSMediumTextField {
    
    var leftEmailView: UIView {
        let imgView = UIImageView(image: UIImage(named: ""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftEmailView
        
        self.keyboardType = .emailAddress
        self.autocorrectionType = .no
        
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 0.2)), size: CGSize(width: CGFloat(padding) * 0, height: bounds.height -  CGFloat(padding * 0.1)))
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}
class SSPasswordTextField: SSMediumTextField {
    
    var leftPasswordView: UIView {
        let imgView = UIImageView(image: UIImage(named: ""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftPasswordView
        
        self.isSecureTextEntry = true
        self.keyboardType = .default
        self.autocorrectionType = .no
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 0.2)), size: CGSize(width: CGFloat(padding) * 0, height: bounds.height -  CGFloat(padding * 0.1)))
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}
class SSUsernameTextField: SSMediumTextField {
    
    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named:""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    let paddings = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 0.2)), size: CGSize(width: CGFloat(padding) * 0, height: bounds.height -  CGFloat(padding * 0.1)))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SSAddressTextField: SSMediumTextField {
    
    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named:""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 0.2)), size: CGSize(width: CGFloat(padding) * 0, height: bounds.height -  CGFloat(padding * 0.1)))
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SSBirthDateTextField: SSMediumTextField, UITextFieldDelegate {
    
    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: ""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    let paddings = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    let dpDate = UIDatePicker()
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
//        self.leftViewMode = .always
//        self.tintColor = SSColor.appWhite
        self.tintColor = .clear
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SSColor.appWhite])
        
        dpDate.datePickerMode = .date
        if #available(iOS 13.4, *) {
            dpDate.preferredDatePickerStyle = .wheels
            dpDate.backgroundColor = .white
            dpDate.maximumDate = Date()
            dpDate.setValue(UIColor.black, forKeyPath: "textColor")
            dpDate.setValue(false, forKeyPath: "highlightsToday")
            
        } else {
            // Fallback on earlier versions
        }
        inputView = dpDate
        dpDate.setDate(Date(), animated: false)
        crossButtonView.contentMode = .center
        crossButtonView.setImage(UIImage(named: ""), for: UIControl.State.normal)
        
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.text = DateTimeManager.shared.stringFrom(date: dpDate.date, inFormate: DateFormate.MMM_DD_COM_yyyy)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.text = DateTimeManager.shared.stringFrom(date: dpDate.date, inFormate: DateFormate.MMM_DD_COM_yyyy)

    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
    }
}
class SSDiseaseTextField: SSMediumTextField, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
   
    var rightUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SSImageName.iconDropDown))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    let paddings = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    let pvGender = UIPickerView()
    let pvOptions: [String] = []
    var selectedOption: String? {
        didSet {
            self.text = selectedOption
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        rightView = rightUserView
//        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
//        self.leftViewMode = .always
        rightViewMode = .always
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.tintColor = .clear
        
        pvGender.dataSource = self
        pvGender.delegate = self
        inputView = pvGender
        
        crossButtonView.contentMode = .center
        crossButtonView.setImage(UIImage(named: ""), for: UIControl.State.normal)
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: self.bounds.width - CGFloat(padding * 4), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 2, height: bounds.height -  CGFloat(padding * 3.2)))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if selectedOption == nil {
            selectedOption = pvOptions.first
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pvOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.delegate = self
    }
    
    
}

class SSTitleTextField: SSMediumTextField {
    
    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named:""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 0.2)), size: CGSize(width: CGFloat(padding) * 0, height: bounds.height -  CGFloat(padding * 0.1)))
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}
class SSMobileNumberTextField: SSMediumTextField {
    
    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: ""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        self.keyboardType = .numberPad
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 0.2)), size: CGSize(width: CGFloat(padding) * 0, height: bounds.height -  CGFloat(padding * 0.1)))
    }
    
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}
class SSRelationshipTextField: SSMediumTextField, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    var rightUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SSImageName.iconDropDown))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    let paddings = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    let pvGender = UIPickerView()
    //,"Others"
   

    var pvOptions: [String] = []

    
    

    
    var selectedOption: String? {
        didSet {
            self.text = selectedOption
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        rightView = rightUserView
        //        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        //        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
        //        self.tintColor = SSColor.appWhite
        rightViewMode = .always
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.tintColor = .clear
        
        pvGender.dataSource = self
        pvGender.delegate = self
        inputView = pvGender
        
        crossButtonView.contentMode = .center
        crossButtonView.setImage(UIImage(named: ""), for: UIControl.State.normal)
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: self.bounds.width - CGFloat(padding * 4), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 2, height: bounds.height -  CGFloat(padding * 3.2)))
        
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddings)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddings)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddings)
    }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if selectedOption == nil {
            selectedOption = pvOptions.first
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pvOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
    }
}

class SSGenderTextField: SSMediumTextField, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var rightUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SSImageName.iconDropDown))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    let paddings = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    let pvGender = UIPickerView()
    //,"Others"
    let pvOptions: [String] = ["Male","Female"]
    var selectedOption: String? {
        didSet {
            self.text = selectedOption
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        rightView = rightUserView
//        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
//        self.tintColor = SSColor.appWhite
        rightViewMode = .always
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.tintColor = .clear
        
        pvGender.dataSource = self
        pvGender.delegate = self
        inputView = pvGender
        
        crossButtonView.contentMode = .center
        crossButtonView.setImage(UIImage(named: ""), for: UIControl.State.normal)
    }
    
    //------------------------------------------------------
    
    //MARK: Override

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: self.bounds.width - CGFloat(padding * 4), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 2, height: bounds.height -  CGFloat(padding * 3.2)))

    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if selectedOption == nil {
            selectedOption = pvOptions.first
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pvOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
    }
}

class SSHospitalTextField: SSMediumTextField, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var rightUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SSImageName.iconDropDown))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    let paddings = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    let pvGender = UIPickerView()
    var pvOptions: [String] = []
    var selectedOption: String? {
        didSet {
            self.text = selectedOption
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        rightView = rightUserView
//        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height))
        rightViewMode = .always
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.tintColor = .clear
        
        pvGender.dataSource = self
        pvGender.delegate = self
        inputView = pvGender
        
        crossButtonView.contentMode = .center
        crossButtonView.setImage(UIImage(named: ""), for: UIControl.State.normal)
    }
    
    //------------------------------------------------------
    
    //MARK: Override

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: self.bounds.width - CGFloat(padding * 4), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 2, height: bounds.height -  CGFloat(padding * 3.2)))

    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if selectedOption == nil {
            selectedOption = pvOptions.first
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pvOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
    }
   
}

class SSDoctorTextField: SSMediumTextField, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var rightUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SSImageName.iconDropDown))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    let paddings = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 5)
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    let pvDoctor = UIPickerView()
    var pvOptions: [String] = []
    var selectedOption: String? {
        didSet {
            self.text = selectedOption
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        rightView = rightUserView
        rightViewMode = .always

        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.tintColor = .clear
        
        pvDoctor.dataSource = self
        pvDoctor.delegate = self
        inputView = pvDoctor
        
        crossButtonView.contentMode = .center
        crossButtonView.setImage(UIImage(named: ""), for: UIControl.State.normal)
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: self.bounds.width - CGFloat(padding * 4), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 2, height: bounds.height -  CGFloat(padding * 3.2)))

    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
     
     override func textRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.inset(by: paddings)
     }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if selectedOption == nil {
            selectedOption = pvOptions.first
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pvOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
    }
}

