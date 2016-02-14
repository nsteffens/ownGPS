//
//  LocationTableViewCell.swift
//  ownGPS
//
//  Created by Nico Steffens on 14.02.16.
//  Copyright © 2016 Nico. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
// MARK: Properties
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
