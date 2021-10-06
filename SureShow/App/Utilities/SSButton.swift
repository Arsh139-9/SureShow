//
//  PMButton.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import Foundation
import UIKit

class SSBaseButton: UIButton {

    var fontDefaultSize : CGFloat {
        return self.titleLabel?.font.pointSize ?? 0.0
    }
    var fontSize : CGFloat = 0.0
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
    }
}

class SSRegularButton: SSBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = SSFont.PoppinsRegular(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class SSMediumButton: SSBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = SSFont.PoppinsMedium(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}
class SSLightButton: SSBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = SSFont.PoppinsLight(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class SSSemiboldButton: SSBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = SSFont.PoppinsSemiBold(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class SSActiveButton: SSMediumButton {

    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
                
        self.cornerRadius = SSSettings.cornerRadius
        self.shadowOffset = CGSize.zero
//        self.shadowOpacity = FGSettings.shadowOpacity
        
        self.backgroundColor = SSColor.appButton
        //self.setBackgroundImage(UIImage(named: TFImageName.background), for: .normal)
        self.clipsToBounds = true
    }
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
             
       setup()
    }
}
class SSRememberMeButton: SSRegularButton {

    var isRemember: Bool = false {
        didSet {
            if isRemember {
                self.setImage(UIImage(named: SSImageName.iconCheck), for: .normal)
            } else {
                self.setImage(UIImage(named: SSImageName.iconUncheck), for: .normal)
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        isRemember = false
        
        let padding: CGFloat = 4
        imageEdgeInsets = UIEdgeInsets(top: padding, left: CGFloat.zero, bottom: padding, right: padding)
        
        addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @objc func click(_ sender: SSRememberMeButton) {
        sender.isRemember.toggle()
    }
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}
