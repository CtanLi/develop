//
//  FaxCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-16.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class FaxCell: UITableViewCell, Reusable {

     //Outlets
    @IBOutlet weak var faxNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var faxResource = Resources() {
        didSet {
            faxNumber.text = String(faxResource.faxNumber)
        }
    }
}
