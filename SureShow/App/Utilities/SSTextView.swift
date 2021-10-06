//
//  FGTextView.swift
//  Fringe
//
//  Created by Dharmani Apps on 11/08/21.
//

import Foundation
import UIKit

class SSBaseTextView: UITextView {
    
    public var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    public var fontSize : CGFloat = 0.0
    
    public var padding: Double = 8
    
    private var leftEmptyView: UIView {
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: padding, height: Double.zero)))
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
//        self.borderColor = FGColor.appWhite
//        self.shadowColor = FGColor.appWhite
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = SSSettings.shadowOpacity
//        self.tintColor = FGColor.appWhite
//        self.textColor = FGColor.appWhite
    }
    
    fileprivate func HighlightLayer() {
        self.borderColor = SSColor.appButton
        self.buttonColor = SSColor.appButton
    }
    
    fileprivate func resetLayer() {
//        self.borderColor = FGColor.appWhite
//        self.tintColor = FGColor.appWhite
    }
        
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

class SSRegularWithoutBorderTextView: UITextView {

    public var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        let fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
        self.font = SSFont.PoppinsRegular(size: fontSize)
    }
}

class FGRegularTextView: SSBaseTextView {

    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SSFont.PoppinsRegular(size: fontSize)
    }
}



