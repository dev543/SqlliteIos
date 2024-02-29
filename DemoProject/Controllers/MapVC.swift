//
//  MapVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 16/01/24.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    //MARK: Outlate
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var mapView  : MKMapView!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    var latitudeFlag  : Double?
    var longitudeFlag : Double?
    var locationName  : String?
    
    let regionRadius: CLLocationDistance = 1000
    
    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup(){
        self.applyTheme()
    }
    
    func applyTheme() {
        
        self.lblTitle.text = self.locationName
        
        guard let latitude = self.latitudeFlag, let longitude = self.longitudeFlag else {
               return
           }

        let location = CLLocation(latitude: latitude, longitude: longitude)
           self.map(location: location)
           self.addLocationPin()
       }
    
    func addLocationPin() {
        
        guard let latitude = self.latitudeFlag, let longitude = self.longitudeFlag else {
            return
        }

        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "\(String(describing: self.locationName!))"
        self.mapView.addAnnotation(annotation)
    }
    
    // Function to map on a location
       func map(location: CLLocation) {
           let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
           self.mapView.setRegion(region, animated: true)
       }
    
    //-----------------------------------------
    
    //MARK: Action
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
     
    //-----------------------------------------
    
    //MARK: Life-Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.leftBarButtonItem?.isHidden = true
        self.navigationItem.hidesBackButton = true
    }
    
    //-----------------------------------------
}

