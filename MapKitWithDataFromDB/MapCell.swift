//
//  MapCell.swift
//  MapKitWithDataFromDB
//
//  Created by sarkom5 on 16/05/19.
//  Copyright © 2019 sarkom5. All rights reserved.
//

import UIKit

class MapCell: UITableViewCell {

    @IBOutlet weak var cityOfPlaceLabel: UILabel!
    @IBOutlet weak var cityOfDestinationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
