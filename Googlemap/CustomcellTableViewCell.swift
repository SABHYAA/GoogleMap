//
//  CustomcellTableViewCell.swift
//  Googlemap
//
//  Created by appinventiv on 13/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class CustomcellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startlattitudeLabel: UILabel!
    
    @IBOutlet weak var startlongitudeLable: UILabel!
    
    @IBOutlet weak var endLattitudeLabel: UILabel!
    
    @IBOutlet weak var endLongitudeLabel: UILabel!
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
