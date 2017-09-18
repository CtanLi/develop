//
//  ViewController.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-13.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class CategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource, Reusable {
    
    var categoryName = [String]()
    var categoryTime = [String]()
    
    //Outlet
    @IBOutlet weak var categoryTableView: UITableView!
    
    //
    //MARK:- Override
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Categories"
        getCategories()
    }
    
    //
    //MARK:- Operations
    //
    
    func getCategories() {
        do {
            if let file = Bundle.main.url(forResource: "categories", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    
                    if let array = object as? [[String: Any]] {
                        //array of task id
                        let titleNames = array.flatMap { $0["title"] as? String }
                        let timeCreated = array.flatMap { $0["created_at"] as? String }
                        
                        let title = titleNames as [String]
                        let time = timeCreated as [String]
                        
                        for item in title {
                            categoryName.append(item)
                        }
                        
                        for time in time {
                            categoryTime.append(time)
                        }
                        
                        print(titleNames)
                    }
                    
                }
            }
        } catch {
            
            print(error.localizedDescription)
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
        return categoryName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
            as! CategoryCell
        
        let myDate = categoryTime[indexPath.row]
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let date = dateFormatter.date(from: myDate)
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date!)
        print("EXACT_DATE : \(dateString)")
        
        cell.titleName.text = categoryName[indexPath.row]
        cell.timeCreated.text = dateString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = categoryName[indexPath.row]
        let myStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let detailController = myStoryBoard.instantiateViewController(withIdentifier: ResourcesController.identifier) as! ResourcesController
        detailController.selectedItem = selectedCell
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
