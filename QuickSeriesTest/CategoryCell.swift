//
//  CategoryCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-13.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell, Reusable {

    //Outlets
    @IBOutlet weak var timeCreated: UILabel!
    @IBOutlet weak var titleName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
