//
//  NoteCell.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-16.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell, Reusable {

    var fbFunction: (() -> (Void))!
    var twtFunction: (() -> (Void))!
    var youTubeFunction: (() -> (Void))!
    
     //Outlets
    @IBOutlet weak var faceBookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        fbFunction()
    }
    @IBAction func twitterAction(_ sender: Any) {
        twtFunction()
    }
    @IBAction func youtubeAction(_ sender: Any) {
        youTubeFunction()
    }
    
    func setFbAction(_ function: @escaping () -> Void) {
        self.fbFunction = function
    }
    
    func setTwtAction(_ function: @escaping () -> Void) {
        self.twtFunction = function
    }
    
    func setYouTubeAction(_ function: @escaping () -> Void) {
        self.youTubeFunction = function
    }
   
}
