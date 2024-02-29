//
//  DetailVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 16/01/24.
//

import UIKit

class DetailVC: UIViewController {
    
    //MARK: Outlate
    
    @IBOutlet weak var navTitle       : UINavigationItem!
    @IBOutlet weak var btnBack        : UIBarButtonItem!
    
    @IBOutlet weak var lblJobTitle    : UILabel!
    @IBOutlet weak var lblTitle       : UILabel!
    @IBOutlet weak var lblDetail      : UILabel!
    @IBOutlet weak var lblDetailTitle : UILabel!
    
    @IBOutlet weak var imgProfile     :  UIImageView!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    var jobTitleFlage : String?
    var detailsFlage  : String?
    var imageFlage    : String?
    var nameFlage     : String?
    
    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup(){
        self.applyTheme()
        self.setData()
    }
    
    func applyTheme(){
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.lblJobTitle.text   =   AppMessages.jobTitle
        self.lblDetail.text     = AppMessages.detail
        
        self.imgProfile.layer.cornerRadius = 10.0
        
    }
     
    func setData(){
        
        self.navTitle.title        = nameFlage
        self.lblTitle.text         = jobTitleFlage
        self.lblDetailTitle.text   = detailsFlage
        
        let url = URL(string: imageFlage ?? "")!
        self.imgProfile.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
//            let data = try? Data(contentsOf: url)
//
//            if let imageData = data {
//                self.imgProfile.image = UIImage(data: imageData)
//            }
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
        self.navigationController?.isNavigationBarHidden = false
        if #available(iOS 16.0, *) {
            self.navigationItem.leftBarButtonItem?.isHidden = false
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.hidesBackButton = false
    }

}
