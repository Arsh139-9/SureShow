//
//  ProfileTVCell.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit

class ProfileTVCell: UITableViewCell {
    
    @IBOutlet weak var lblName: SSMediumLabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(image: String, name: String?) {
        
        imgIcon.image = UIImage(named: image)
        lblName.text = name
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
