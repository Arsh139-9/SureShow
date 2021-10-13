//
//  HomeTVCell.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit

class HomeTVCell: UITableViewCell {
    
    @IBOutlet weak var lblGender: SSRegularLabel!
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
