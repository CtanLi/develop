//
//  WebSiteCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-16.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class WebSiteCell: UITableViewCell, Reusable {

    @IBOutlet weak var webLink: UILabel!
    
    var webFunction: (() -> (Void))!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var webResource = Resources() {
        didSet {
            webLink.text = webResource.website
        }
    }
    
    
    @IBAction func webAction(_ sender: Any) {
        webFunction()
    }
    
    func setAction(_ function: @escaping () -> Void) {
        self.webFunction = function
    }
}
