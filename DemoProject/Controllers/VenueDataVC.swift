//
//  VenueDataVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 16/01/24.
//

import UIKit
import Alamofire
import SwiftyJSON

class VenueDataVC: UIViewController {

    //MARK: Outlate
    
    @IBOutlet weak var tblData      : UITableView!
    
    @IBOutlet weak var btnClose     : UIButton!
    @IBOutlet weak var btnSearch    : UIButton!
    @IBOutlet weak var lblTitle     : UILabel!
    @IBOutlet weak var lblDataCount : UILabel!
    @IBOutlet weak var searchBar    : UISearchBar!
    
    @IBOutlet weak var loader       : UIActivityIndicatorView!
    
    //-----------------------------------------
    //MARK: - Custom Variables
    
    var arrvenues  : [VenueModel] = []
    var arrDisplay : [VenueModel] = []
    var venueData  : VenueModel?
        
    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup(){
        
        if !UserDefaults.standard.getApi(){
            print("😁😁😁 api call 😁😁😁")
            self.apiCall()
            self.arrDisplay = self.arrvenues
            
        }else{
            
            self.loader.startAnimating()
            self.arrvenues = DatabaseManager.getInstance().read()
            print("😁😁😁 Data get FROM Database 😁😁😁")
            self.arrDisplay = self.arrvenues
            self.loader.stopAnimating()
            self.loader.isHidden = true
        }
        
        self.applyTheme()
        
    }
    
    func applyTheme(){
        
        self.lblDataCount.font = UIFont.systemFont(ofSize: 12.0)
        self.lblTitle.text     = AppMessages.venueData
    
        self.lblDataCount.text = "\(self.arrvenues.count)"
        
        self.tblData.delegate   = self
        self.tblData.dataSource = self
        
        let cellNib = UINib(nibName: "VenueDataXib", bundle: nil)
        self.tblData.register(cellNib, forCellReuseIdentifier: "VenueDataXibClass")
        
    }

//     API call function
    func apiCall() {
        
        let apiUrl = "https://coinmap.org/api/v1/venues/"
        
        self.loader.startAnimating()
        
        AF.request(apiUrl, method: .get).responseJSON { [weak self] response in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.loader.isHidden = true

                switch response.result {
                case .success(let value):
                    guard let jsonData = value as? [String: Any],
                          let venuesArray = jsonData["venues"] as? [[String: Any]] else {
                        print("Invalid JSON response")
                        return
                    }

                    self.arrvenues = venuesArray.compactMap { venueDict in
                        guard let name = venueDict["name"] as? String,
                              let category = venueDict["category"] as? String,
                              let latitude = venueDict["lat"] as? Double,
                              let longitude = venueDict["lon"] as? Double else {
                            print("Invalid venue data: \(venueDict)")
                            return nil
                        }

                        let venue = VenueModel(name: name, category: category, latitude: latitude, longitude: longitude)

                        DBHelper.shared.insertVenue(venue: venue)

                        return venue
                    }
                    
                    UserDefaults.standard.setApi(isApi: true)

                    self.lblDataCount.text = "\(self.arrvenues.count)"
                    self.tblData.reloadData()

                case .failure(let error):
                    print("API Call Fail: \(error)")
                }
                self.tblData.reloadData()
            }
        }
    }

    //-----------------------------------------
    
    //MARK: Action
    
    @IBAction func btnCloseClick(_ sender: Any) {
        self.searchBar.isHidden = true
        self.btnClose.isHidden  = true
        self.lblTitle.isHidden  = false
        self.btnSearch.isHidden = false
        self.lblDataCount.isHidden = false
        self.searchBar.endEditing(true)
        self.tblData.reloadData()
    }
    
    @IBAction func btnSearchClick(_ sender: Any) {
        self.searchBar.isHidden = false
        self.lblTitle.isHidden  = true
        self.btnClose.isHidden  = false
        self.btnSearch.isHidden = true
        self.lblDataCount.isHidden = true
        self.searchBar.text = ""
        
    }
    //-----------------------------------------
    
    //MARK: Life-Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationItem.leftBarButtonItem?.isHidden  = true
        self.navigationItem.hidesBackButton = true
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource methods

extension VenueDataVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchBar.isHidden {
            
            return self.arrvenues.count
         }
        return self.arrDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCell  = tableView.dequeueReusableCell(withIdentifier: "VenueDataXibClass", for: indexPath) as! VenueDataXibClass

        if self.searchBar.isHidden {
            objCell.confing((self.arrvenues[indexPath.row]))
        }else{
            objCell.confing((self.arrDisplay[indexPath.row]))
        }
        return objCell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedVenue = self.arrvenues[indexPath.row]
        let selectedVenue: VenueModel

         if searchBar.isHidden {
             selectedVenue = self.arrvenues[indexPath.row]
         } else {
             selectedVenue = self.arrDisplay[indexPath.row]
         }
        
        DBHelper.shared.insertHistory(history: HistoryModel(
            id: 0 ,
            image: AppMessages.imgLocation,
            name: selectedVenue.name ?? "",
            title: selectedVenue.category ?? "",
            date: "13/10/21",
            latitude: selectedVenue.latitude ?? 0.0,
            longitude: selectedVenue.longitude ?? 0.0
        ))
     
        // Navigate to the map screen
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = storyBoard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        mapVC.latitudeFlag = selectedVenue.latitude
        mapVC.longitudeFlag = selectedVenue.longitude
        mapVC.locationName = selectedVenue.name
        self.navigationController?.pushViewController(mapVC, animated: true)
    }

}

//-----------------------------------------------------

//MARK: - UISearchBarDelegate methods

extension VenueDataVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search Text: \(searchText)")
        
        if searchText.isEmpty {
            self.arrDisplay = self.arrvenues
        } else {
            self.arrDisplay = self.arrvenues.filter { venue in
                if let name = venue.name {
                    return name.lowercased().contains(searchText.lowercased())
                } else {
                    return false
                }
            }
        }
        self.tblData.reloadData()
    }
     
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
        {
            self.searchBar.endEditing(true)
        }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("Search Text: \(searchText)")
//        if searchText.isEmpty {
//            self.arrDisplay = self.arrvenues
//        } else {
//            self.arrDisplay = self.arrvenues.filter { venue in
//                return venue.name!.lowercased().contains(searchText.lowercased())
//
//            }
//        }
//        self.tblData.reloadData()
//    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("Search Text: \(searchText)")
//
//        if searchText.isEmpty {
//            self.arrDisplay = self.arrvenues
//            self.tblData.reloadData()
//        } else {
//
//            self.arrDisplay = DatabaseManager.shared.search(searchText: searchText)
//        }
//
//        self.tblData.reloadData()
//    }

}

//-----------------------------------------------------


