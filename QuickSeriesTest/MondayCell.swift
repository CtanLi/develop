//
//  MondayCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-17.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class MondayCell: UITableViewCell, Reusable {

    @IBOutlet weak var mondayFromDate: UILabel!
    @IBOutlet weak var mondayToDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var mondayResource = Resources() {
        didSet {
            mondayFromDate.text = mondayResource.mondayFromDate
            mondayToDate.text = mondayResource.mondayToDate
        }
    }

}
