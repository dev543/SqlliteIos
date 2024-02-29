//
//  VenueDataXibClass.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 16/01/24.
//

import UIKit
import SwiftyJSON

class VenueDataXibClass: UITableViewCell {

    //MARK: - Outlates

    @IBOutlet weak var imgLocation  : UIImageView!
    
    @IBOutlet weak var lblName      : UILabel!
    @IBOutlet weak var lblTitle     : UILabel!
    @IBOutlet weak var lblDate      : UILabel!
    
    @IBOutlet weak var vwMain       : UIView!
    
    //-----------------------------------------
    //MARK: - Custom Variables
        
    //-----------------------------------------
    
    //MARK: - Custom Methods
    
    func setupView() {
        self.applyTheme()
        
    }
    
    func applyTheme() {
        
        self.vwMain.layer.cornerRadius = 10
        self.vwMain.layer.borderColor  = UIColor.black.cgColor
        self.vwMain.layer.borderWidth  = 1
        
        self.lblDate.text   = "09/06/2013"
        
    }

    //confing Function
    
    func confing(_ venue: VenueModel){
        self.lblName.text   = venue.name
        self.lblTitle.text  = venue.category
        self.imgLocation.image = UIImage(named: AppMessages.imgLocation)
    }

    //----------------------------------------
    
    //MARK: - Actions
    
    //----------------------------------------
    
    //MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    //----------------------------------------

}
