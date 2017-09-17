////
////  Service.swift
////  QuickSeriesTest
////
////  Created by CtanLI on 2017-09-16.
////  Copyright © 2017 QuickSeries. All rights reserved.
////
//
//import UIKit
//
//struct LoadFeedService {
//    
//    static let sharedInstance  = LoadFeedService()
//
//
//    func getRestuarantInfos(completion: @escaping ([Resources]) -> ()) {
//        
//        
//        //        guard selectedItem == selectedCounts.restuarant.rawValue else {
//        //            return
//        //        }
//        
//        do {
//            if let file = Bundle.main.url(forResource: "restaurants", withExtension: "json") {
//                let data = try Data(contentsOf: file)
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                
//                if let object = json as? [Any] {
//                    // json is an array
//                    var resources = [Resources]()
//                    var selectedItem = [String]()
//                    
//                    if let jsonArray = object as? [[String: AnyObject]] {
//                        //If you want array of task id you can try like
//                        let resourceData = Resources()
//                        for resource in jsonArray {
//                            let detail = resource
//                            let resourceDetail = detail["slug"] as! String
//                            if self.selectedItem.first == resourceDetail {
//                                
//                                let title = detail["title"] as! String
//                                resourceData.title = title
//                                let desc = detail["description"] as! String
//                                resourceData.desc = desc
//                                let photo = detail["photo"] as! String
//                                resourceData.photo = photo
//                                
//                                let contatcs = detail["contactInfo"] as! [String: AnyObject]
//                                
//                                if let emailContact = contatcs["email"] as? [String] {
//                                    let email = emailContact.map { (String($0)) }
//                                    resourceData.email = email.first as! String
//                                }
//                                
//                                if let phoneContact = contatcs["phoneNumber"] as? [String] {
//                                    let phone = phoneContact.map { (String($0)) }
//                                    resourceData.phoneNumber = Int(phone.first!!)!
//                                }
//                                
//                                if let tollFreeContact = contatcs["tollFree"] as? [String] {
//                                    let tollFree = tollFreeContact.map { (String($0)) }
//                                    resourceData.tollFree = Int(tollFree.first!!)!
//                                }
//                                
//                                if let faxContact = contatcs["faxNumber"] as? [String] {
//                                    let faxNumber = faxContact.map { (String($0)) }
//                                    resourceData.faxNumber = Int(faxNumber.first!!)!
//                                }
//                                
//                                if let webContact = contatcs["website"] as? [String] {
//                                    let web = webContact.map { (String($0)) }
//                                    resourceData.website = web.first as! String
//                                    print(web.first! as Any)
//                                }
//                                
//                                
//                                if let address = detail["addresses"] as? [[String: AnyObject]] {
//                                    let address1 = address.map({ $0["address1"] as? String ?? ""})
//                                    resourceData.address1 = address1.first!
//                                    
//                                    let state = address.map({ $0["state"] as? String ?? ""})
//                                    resourceData.state = state.first!
//                                    
//                                    let city = address.map({ $0["city"] as? String ?? ""})
//                                    resourceData.city = city.first!
//                                    
//                                    let country = address.map({ $0["country"] as? String ?? ""})
//                                    resourceData.country = country.first!
//                                    
//                                    let zipCode = address.map({ $0["zipCode"] as? String ?? ""})
//                                    resourceData.zipCode = zipCode.first!
//                                    
//                                    let gps = address.map({ $0["gps"] as? [String: String]})
//                                    let lat = gps.map({ $0?["latitude"] ?? ""})
//                                    resourceData.latitude = lat.first!
//                                    
//                                    let lng = gps.map({ $0?["longitude"] ?? ""})
//                                    resourceData.longitude = lng.first!
//                                    
//                                }
//                                
//                                let hours = detail["bizHours"] as? [String: AnyObject]
//                                let sunday = hours?["sunday"] as? [String: String]
//                                
//                                let to = sunday.map({ $0["to"] ?? ""})
//                                resourceData.sundayToDate = (to != nil) ? to! : ""
//                                let from = sunday.map({ $0["from"] ?? ""})
//                                resourceData.sundayFromDate = (from != nil) ? from! : ""
//                                
//                                let monday = hours?["monday"] as? [String: String]
//                                let toDate = monday.map({ $0["to"] ?? ""})
//                                resourceData.mondayToDate = (toDate != nil) ? toDate! : ""
//                                let fromDate = monday.map({ $0["from"] ?? ""})
//                                resourceData.mondayFromDate = (fromDate != nil) ? fromDate! : ""
//                                
//                                resources.append(resourceData)
//                            }
//                        }
//                    }
//                }
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
//
