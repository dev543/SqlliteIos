//
//  FSPagerImageXibClass.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 23/01/24.
//

import UIKit

class FSPagerImageXibClass: UICollectionViewCell {

    //MARK: - Outlates
    
    @IBOutlet weak var imgPost      : UIImageView!
    
    //-----------------------------------------
    //MARK: - Custom Variables
    
    //-----------------------------------------
    
    //MARK: - Custom Methods
    
    func setupView() {
        self.applyTheme()
        
    }
    
    func applyTheme() {
   
    }

    //confing Function
    
    func confing(_ images: String) {
        self.imgPost.image = UIImage(named: images)
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
