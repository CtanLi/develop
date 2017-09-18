//
//  BusinessCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-16.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class SundayCell: UITableViewCell, Reusable {

     //Outlets
    @IBOutlet weak var sundayFromDate: UILabel!
    @IBOutlet weak var sundayToDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var sundayResource = Resources() {
        didSet {
            sundayFromDate.text = sundayResource.sundayFromDate
            sundayToDate.text = sundayResource.sundayToDate
        }
    }
}
