//
//  RestuarantCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-14.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class ResourcesCell: UITableViewCell, Reusable {

    //OutLets
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var placeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    var resource = Resources() {
        didSet {
            
            //let title = resource.title
            
           
        }
    }
}
