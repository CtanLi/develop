//
//  DetailController.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-15.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit
import MessageUI
import MapKit
import CoreLocation

enum DetailSection: Int {

    case image
    case phoneContact
    case faxContact
    case tollFreeContact
    case email
    case webLink
    case address
    case notes
    case sunday
    case monday
    
    static var numberOfSection: Int {
        return 10
    }
}

class DetailsController: UIViewController, Reusable, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    private struct Constraints {
        static let titleSectionHeaderHeight: CGFloat    = 230.0
        static let defaultSectionHeaderHeight: CGFloat  = 1.0
        static let bodySectionHeaderHeight: CGFloat = 60.0
        static let businessSectionHeaderHeight: CGFloat = 180.0
    }

    //outlets
    @IBOutlet weak var detailTable: UITableView!
    
    //vars
    var email = ""
    var address = ""
    var webLink = ""
    var coords: CLLocationCoordinate2D?
    var selectedItem = [String]()
    var placeTitle = [String]()
    var decriptionText = [String]()
    var image = [String]()
    var photos = [String]()
    var decription = [String]()
    var titleNames = [String]()
    var identifier = [String]()
    
    
    //
    //MARK:- Override
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTable.estimatedRowHeight = 500
        detailTable.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resources.removeAll()
        getRestuarantInfos()
        getVacationInfos()
    }
    
    var resources = [Resources]() {
        didSet {
            detailTable?.reloadData()
        }
    }
    
    //
    //MARK:- Operations
    //
    
    func getRestuarantInfos() {
        guard selectedItem.first != selectedCounts.resoucrces.rawValue else {
            return
        }
        
        do {
            if let file = Bundle.main.url(forResource: "restaurants", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    
                    if let jsonArray = object as? [[String: AnyObject]] {
                        //If you want array of task id you can try like
                        let resourceData = Resources()
                        for resource in jsonArray {
                            let detail = resource
                            let resourceDetail = detail["slug"] as! String
                            if self.selectedItem.first == resourceDetail {

                                let title = detail["title"] as! String
                                resourceData.title = title
                                let desc = detail["description"] as! String
                                resourceData.desc = desc
                                let photo = detail["photo"] as! String
                                resourceData.photo = photo
                                
                                let contacts = detail["contactInfo"] as! [String: AnyObject]
                                
                                if let emailContact = contacts["email"] as? [String] {
                                    let email = emailContact.map { (String($0)) }
                                    resourceData.email = (email.first as? String)!
                                }
                                
                                if let phoneContact = contacts["phoneNumber"] as? [String] {
                                    let phone = phoneContact.map { (String($0)) }
                                    resourceData.phoneNumber = Int(phone.first!!)!
                                }
                                
                                if let tollFreeContact = contacts["tollFree"] as? [String] {
                                    let tollFree = tollFreeContact.map { (String($0)) }
                                    resourceData.tollFree = Int(tollFree.first!!)!
                                }
                                
                                if let faxContact = contacts["faxNumber"] as? [String] {
                                    let faxNumber = faxContact.map { (String($0)) }
                                    resourceData.faxNumber = Int(faxNumber.first!!)!
                                }
                                
                                if let webContact = contacts["website"] as? [String] {
                                    let web = webContact.map { (String($0)) }
                                    resourceData.website = (web.first as? String)!
                                    print(web.first! as Any)
                                }
                                
                                let socialMedia = detail["socialMedia"] as? [String: AnyObject]
                                
                                if let youtubeChannel = socialMedia?["youtubeChannel"] as? [String] {
                                    let youtube = youtubeChannel.map { (String($0)) }
                                    resourceData.youtubeChannel = (youtube.first as? String)!
                                }
                                
                                if let twitter = socialMedia?["twitter"] as? [String] {
                                    let twt = twitter.map { (String($0)) }
                                    resourceData.twitter = twt.first!!
                                }
                                
                                if let facebook = socialMedia?["facebook"] as? [String] {
                                    let fb = facebook.map { (String($0)) }
                                    resourceData.facebook = (fb.first as? String)!
                                }
                                
                                
                                if let address = detail["addresses"] as? [[String: AnyObject]] {
                                    let address1 = address.map({ $0["address1"] as? String ?? ""})
                                    resourceData.address1 = address1.first!
                                    
                                    let state = address.map({ $0["state"] as? String ?? ""})
                                    resourceData.state = state.first!
                                    
                                    let city = address.map({ $0["city"] as? String ?? ""})
                                    resourceData.city = city.first!
                                    
                                    let country = address.map({ $0["country"] as? String ?? ""})
                                    resourceData.country = country.first!
                                    
                                    let zipCode = address.map({ $0["zipCode"] as? String ?? ""})
                                    resourceData.zipCode = zipCode.first!
              
                                    let gps = address.map({ $0["gps"] as? [String: String]})
                                    let lat = gps.map({ $0?["latitude"] ?? ""})
                                    resourceData.latitude = lat.first!
                                    
                                    let lng = gps.map({ $0?["longitude"] ?? ""})
                                    resourceData.longitude = lng.first!
                                    
                                }
                                
                                    let hours = detail["bizHours"] as? [String: AnyObject]
                                    let sunday = hours?["sunday"] as? [String: String]
                                
                                    let to = sunday.map({ $0["to"] ?? ""})
                                    resourceData.sundayToDate = (to != nil) ? to! : ""
                                    let from = sunday.map({ $0["from"] ?? ""})
                                    resourceData.sundayFromDate = (from != nil) ? from! : ""
                                
                                    let monday = hours?["monday"] as? [String: String]
                                    let toDate = monday.map({ $0["to"] ?? ""})
                                    resourceData.mondayToDate = (toDate != nil) ? toDate! : ""
                                    let fromDate = monday.map({ $0["from"] ?? ""})
                                    resourceData.mondayFromDate = (fromDate != nil) ? fromDate! : ""
                                    self.resources.append(resourceData)
                            }
                        }
                    }
                }
            }
        } catch {
                print(error.localizedDescription)
            }
        }
    
    func getVacationInfos() {
        guard selectedItem.first == selectedCounts.resoucrces.rawValue else {
            return
        }
        
        do {
            if let file = Bundle.main.url(forResource: "vacation-spot", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    
                    if let jsonArray = object as? [[String: AnyObject]] {
                        //If you want array of task id you can try like
                        let resourceData = Resources()
                        for resource in jsonArray {
                            let detail = resource
                            let resourceDetail = detail["slug"] as! String
                            if self.selectedItem.first == resourceDetail {
                                
                                let title = detail["title"] as! String
                                resourceData.title = title
                                let desc = detail["description"] as! String
                                resourceData.desc = desc
                                let photo = detail["photo"] as! String
                                resourceData.photo = photo
                                self.resources.append(resourceData)
                            }
                        }
                    }
                }
            }
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    //
    // MARK:- implementations
    //
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = DetailSection(rawValue: section) else {
            return 0
        }
        switch section {
            case .image:
                return resources.count
            case .phoneContact:
                return resources.count
            case .faxContact:
                return resources.count
            case .tollFreeContact:
                return resources.count
            case .email:
                return resources.count
            case .webLink:
                return resources.count
            case .address:
                return resources.count
            case .notes:
                return resources.count
            case .sunday:
                return resources.count
            case .monday:
                return resources.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = DetailSection(rawValue: indexPath.section) else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = NSLocalizedString("empty feed", comment: "empty feed")
            return cell
        }
     
        switch section {
            case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath)  as! DetailCell
                cell.detailResource = resources[indexPath.row]
                return cell
            case .phoneContact:
                let cell = tableView.dequeueReusableCell(withIdentifier: PhoneCell.identifier, for: indexPath)  as! PhoneCell
                cell.phoneResource = resources[indexPath.row]
                return cell
            case .faxContact:
                let cell = tableView.dequeueReusableCell(withIdentifier: FaxCell.identifier, for: indexPath)  as! FaxCell
                cell.faxResource = resources[indexPath.row]
                return cell
            case .tollFreeContact:
                let cell = tableView.dequeueReusableCell(withIdentifier: TollFreeCell.identifier, for: indexPath)  as! TollFreeCell
                cell.tollFreeResource = resources[indexPath.row]
                return cell
            case .email:
                let cell = tableView.dequeueReusableCell(withIdentifier: EmailAddressCell.identifier, for: indexPath)  as! EmailAddressCell
                email = resources[indexPath.row].email
                cell.emailResource = resources[indexPath.row]
                
                cell.setAction {                    
                    let mailComposeViewController = self.configuredMailComposeViewController()
                    if MFMailComposeViewController.canSendMail() {
                        self.present(mailComposeViewController, animated: true, completion: nil)
                    } else {
                        self.showSendMailErrorAlert()
                    }
                }
                return cell
            case .webLink:
                let cell = tableView.dequeueReusableCell(withIdentifier: WebSiteCell.identifier, for: indexPath)  as! WebSiteCell
                webLink = resources[indexPath.row].website
                cell.webResource = resources[indexPath.row]
                cell.setAction {
                    self.goToWeb()
                }
                return cell
            case .address:
                let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.identifier, for: indexPath)  as! AddressCell
                
                address = resources[indexPath.row].address1
                cell.addressResource = resources[indexPath.row]
                cell.setAction {
                    self.addressToCoordinatesConverter(address: self.address)
                }
                
                return cell
            case .notes:
                let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath)  as! NoteCell
                
                cell.setFbAction {
                    self.webLink = self.resources[indexPath.row].facebook
                    self.goToWeb()
                }
                
                cell.setTwtAction {
                    self.webLink = self.resources[indexPath.row].twitter
                    self.goToWeb()
                }
                
                cell.setYouTubeAction {
                    self.webLink = self.resources[indexPath.row].youtubeChannel
                    self.goToWeb()
                }
                
                return cell
            case .sunday:
                let cell = tableView.dequeueReusableCell(withIdentifier: SundayCell.identifier, for: indexPath)  as! SundayCell
                cell.sundayResource = resources[indexPath.row]
                return cell
            case .monday:
                let cell = tableView.dequeueReusableCell(withIdentifier: MondayCell.identifier, for: indexPath)  as! MondayCell
                cell.mondayResource = resources[indexPath.row]
                return cell
            }
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let section = DetailSection(rawValue: indexPath.section) {
            switch section {
            case .image:
                if indexPath.row == 0 {
                    return Constraints.titleSectionHeaderHeight
                    }
            case .sunday: break
                default: break
                    }
            return Constraints.bodySectionHeaderHeight
                }
            return Constraints.defaultSectionHeaderHeight
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = DetailSection(rawValue: section) else {
            return ""
        }
        switch section {
            case .phoneContact:
                return "CONTACT INFORMATION"
            case .address:
                return "ADDRESS"
            case .notes:
                return "NOTES"
            case .sunday:
                return "BUSINESS HOURS"
            default: break
        }
        return ""
    }
    
    enum selectedCounts: String {
        case resoucrces = "places-to-read"
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([email])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .cancel, handler: nil))
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    func addressToCoordinatesConverter(address: String) {
        let addressString = "\(address)"
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    self.coords = location!.coordinate
                    self.showMap()
                }
            })
        }
    
    func showMap() {
        let addressDict = ["addressStreetKey" : address]
        let place = MKPlacemark(coordinate: coords!, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: place)
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: options)
    }
    
    func goToWeb() {
        let myStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let resourcesController = myStoryBoard.instantiateViewController(withIdentifier: WebViewController.identifier) as! WebViewController
        resourcesController.webLink = webLink
        self.navigationController?.pushViewController(resourcesController, animated: true)
    }
}
