//
//  QueueTVCell.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit

class QueueTVCell: UITableViewCell {
    
    @IBOutlet weak var lblDate: SSRegularLabel!
    @IBOutlet weak var lblGender: SSMediumLabel!
    @IBOutlet weak var lblAge: SSMediumLabel!
    @IBOutlet weak var lblName: SSSemiboldLabel!
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var deleteQueueBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
