//
//  PMLabel.swift
//  NewProject
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

class SSBaseLabel: UILabel {

    private var fontDefaultSize: CGFloat {
        return font.pointSize
    }
    
    public var fontSize: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
       fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
    }
}

class SSRegularLabel: SSBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SSFont.PoppinsRegular(size: self.fontSize)
    }
}

class SSMediumLabel: SSBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SSFont.PoppinsMedium(size: self.fontSize)
    }
}

class SSLightLabel: SSBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SSFont.PoppinsLight(size: self.fontSize)
    }
}


class SSSemiboldLabel: SSBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SSFont.PoppinsSemiBold(size: self.fontSize)
    }
}



