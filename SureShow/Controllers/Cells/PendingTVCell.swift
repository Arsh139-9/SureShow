//
//  PendingTVCell.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit

class PendingTVCell: UITableViewCell {
    
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnAccept: SSActiveButton!
    @IBOutlet weak var lblTime: SSRegularLabel!
    @IBOutlet weak var lblDate: SSRegularLabel!
    @IBOutlet weak var lblGender: SSMediumLabel!
    @IBOutlet weak var lblAge: SSMediumLabel!
    @IBOutlet weak var lblName: SSSemiboldLabel!
    @IBOutlet weak var imgProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
