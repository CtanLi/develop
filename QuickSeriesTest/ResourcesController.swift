//
//  RestaurantController.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-14.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class ResourcesController: UIViewController, Reusable, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var detailTableView: UITableView!
    
    var selectedItem = String()
    
    var placeTitle = [String]()
    var decriptionText = [String]()
    var newIdentifier = [String]()
    
    
    var decription = [String]()
    var titleNames = [String]()
    var identifier = [String]()
    
    var doubleTap : Bool! = false
    
    
    var resources = [Resources]() {
        didSet {
            detailTableView?.reloadData()
        }
    }
    
    //
    //MARK:- Override
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getRestuarantInfos()
        getVacationInfos()
        
        let addReminder = UIBarButtonItem(title: "Sort", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ResourcesController.sort))
        self.navigationItem.rightBarButtonItem = addReminder
    }
    
    //
    //MARK:- Operations
    //
    
    func getRestuarantInfos() {
        
        guard selectedItem == selectedCounts.restuarant.rawValue else {
            return
        }
        
        do {
            if let file = Bundle.main.url(forResource: "restaurants", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                
                if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    
                    if let array = object as? [[String: Any]] {
                        //If you want array of task id you can try like
                        
                        identifier = array.flatMap { $0["slug"] as? String } as [String]
                        titleNames = array.flatMap { $0["title"] as? String } as [String]
                        decription = array.flatMap { $0["description"] as? String } as [String]
                        
                        let title = titleNames
                        let placeDecription = decription
                        
                        for placeName in title {
                            placeTitle.append(placeName)
                        }
                        
                        for desc in placeDecription {
                            decriptionText.append(desc)
                        }
                    }
                }
            }
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    func getVacationInfos() {
        
        guard selectedItem == selectedCounts.vacationSpots.rawValue else {
            return
        }
        
        do {
            if let file = Bundle.main.url(forResource: "vacation-spot", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    
                    if let array = object as? [[String: Any]] {
                        //array of task id
                       
                        identifier = array.flatMap { $0["slug"] as? String } as [String]
                        titleNames = array.flatMap { $0["title"] as? String }
                        decription = array.flatMap { $0["description"] as? String }
                        
                        let title = titleNames as [String]
                        let placeDecription = decription as [String]
                        
                        for placeName in title {
                            placeTitle.append(placeName)
                        }
                        
                        for desc in placeDecription {
                            decriptionText.append(desc)
                        }
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    // sort array A-Z
    func sort() {
        if doubleTap == false {
            placeTitle.removeAll()
            decriptionText.removeAll()
            newIdentifier.removeAll()
            
            let title = titleNames
            let description = decription
            let id = identifier
            
            let sortedTitle = title.sorted()
            let sortedDescription = description.sorted()
            let newId = id.sorted()
            identifier.removeAll()
            
            for id in newId {
                identifier.append(id)
            }
            
            for placeName in sortedTitle {
                placeTitle.append(placeName)
            }
            
            for desc in sortedDescription {
                decriptionText.append(desc)
            }
   
            detailTableView.reloadData()
            doubleTap = true
            
        } else {
            placeTitle.removeAll()
            decriptionText.removeAll()
            
            let descriptionNames = titleNames
            let description = decription
            
            let sortedTitle = descriptionNames.sorted().reversed()
            let sortedDescription = description.sorted().reversed()
            let newIdentifier = identifier.sorted().reversed()
            identifier.removeAll()
            
            for newId in newIdentifier {
                identifier.append(newId)
            }

            for placeName in sortedTitle {
                placeTitle.append(placeName)
            }
            
            for desc in sortedDescription {
                decriptionText.append(desc)
            }
            
            detailTableView.reloadData()
            doubleTap = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //
    // MARK:- implementations
    //
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResourcesCell.identifier, for: indexPath)
            as! ResourcesCell
        let descText = decriptionText[indexPath.row]
        let newDescription = descText.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        cell.placeTitle.text = placeTitle[indexPath.row]
        cell.descriptionText.text = newDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ids = self.identifier.map({ (id) -> String in
            return id
        })
        
        let storyIdsForDetail = Array(ids[(indexPath as NSIndexPath).row..<ids.count])
        let myStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let resourcesController = myStoryBoard.instantiateViewController(withIdentifier: DetailsController.identifier) as! DetailsController
        resourcesController.selectedItem = storyIdsForDetail
        self.navigationController?.pushViewController(resourcesController, animated: true)
    }
    
    enum selectedCounts: String {
        case restuarant = "Restaurants"
        case  vacationSpots = "Vacation Spots"
    }
}
