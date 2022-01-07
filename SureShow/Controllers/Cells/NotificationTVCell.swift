//
//  NotificationTVCell.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit

class NotificationTVCell: UITableViewCell {
    
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnAccept: SSActiveButton!
    @IBOutlet weak var viewAccept: UIView!
    @IBOutlet weak var lblDate: SSRegularLabel!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTime: SSMediumLabel!
    @IBOutlet weak var lblAppointment: SSRegularLabel!
    @IBOutlet weak var lblName: SSMediumLabel!
    @IBOutlet weak var lblDetails: SSMediumLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
