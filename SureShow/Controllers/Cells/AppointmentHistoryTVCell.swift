//
//  AppointmentHistoryTVCell.swift
//  SureShow
//
//  Created by Apple on 07/10/21.
//

import UIKit

class AppointmentHistoryTVCell: UITableViewCell {
    @IBOutlet weak var lblTime: SSRegularLabel!
    @IBOutlet weak var appointmentCreatedDate: SSRegularLabel!
    @IBOutlet weak var appointmentHistoryDate: SSRegularLabel!
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
