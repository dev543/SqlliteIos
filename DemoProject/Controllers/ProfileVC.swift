//
//  ProfileVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 16/01/24.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {

    //MARK: Outlate
    
    @IBOutlet weak var imgProfile          : UIImageView!
    
    @IBOutlet weak var lblFirstNameTitle   : UILabel!
    @IBOutlet weak var lblFirstName        : UILabel!
    @IBOutlet weak var lblLastNameTitle    : UILabel!
    @IBOutlet weak var lblLastName         : UILabel!
    @IBOutlet weak var lblEmailTitle       : UILabel!
    @IBOutlet weak var lblEmail            : UILabel!
    @IBOutlet weak var lblMobileNoTitle    : UILabel!
    @IBOutlet weak var lblMobileNo         : UILabel!
    @IBOutlet weak var lbldobTitle         : UILabel!
    @IBOutlet weak var lbldob              : UILabel!
    @IBOutlet weak var lblContryTitle      : UILabel!
    @IBOutlet weak var lblContry           : UILabel!
    @IBOutlet weak var lblStateTitle       : UILabel!
    @IBOutlet weak var lblState            : UILabel!
    @IBOutlet weak var lblCityTitle        : UILabel!
    @IBOutlet weak var lblCity             : UILabel!
    @IBOutlet weak var lblGenderTitle      : UILabel!
    @IBOutlet weak var lblGender           : UILabel!
    @IBOutlet weak var lblAboutMeTitle     : UILabel!
    @IBOutlet weak var lblAboutMe          : UILabel!
    
    @IBOutlet weak var btnLogOut           : UIButton!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup(){
        self.applyTheme()
        self.setCurrentUser()
        self.setData()
    }
    
    func applyTheme(){
        
        self.lblFirstNameTitle.text = AppMessages.firstName
        self.lblLastNameTitle.text  = AppMessages.lastName
        self.lblEmailTitle.text     = AppMessages.email
        self.lblMobileNoTitle.text  = AppMessages.mobileNo
        self.lbldobTitle.text       = AppMessages.dob
        self.lblContryTitle.text    = AppMessages.country
        self.lblStateTitle.text     = AppMessages.state
        self.lblCityTitle.text      = AppMessages.city
        self.lblGenderTitle.text    = AppMessages.gender
        self.lblAboutMeTitle.text   = AppMessages.aboutMe
        
        self.lblFirstNameTitle.textColor    = UIColor.purple
        self.lblLastNameTitle.textColor     = UIColor.purple
        self.lblEmailTitle.textColor        = UIColor.purple
        self.lblMobileNoTitle.textColor     = UIColor.purple
        self.lbldobTitle.textColor          = UIColor.purple
        self.lblContryTitle.textColor       = UIColor.purple
        self.lblStateTitle.textColor        = UIColor.purple
        self.lblCityTitle.textColor         = UIColor.purple
        self.lblGenderTitle.textColor       = UIColor.purple
        self.lblAboutMeTitle.textColor      = UIColor.purple
        
        self.btnLogOut.layer.cornerRadius   = 25.0
    }
    
    func setCurrentUser(){
        let email    = UserDefaults.standard.getEmail()
        let password = UserDefaults.standard.getPassword()
        
        if let retrievedUser = DatabaseManager.getInstance().getUser(withEmail: email, password: password)
          {
            
            DatabaseManager.shared.setCurrentUser(retrievedUser)
        
          }
    }
    
    func setData() {
        
         if let currentUser = DatabaseManager.shared.getCurrentUser() {
           
             self.lblFirstName.text   = currentUser.firstName
             self.lblLastName.text    = currentUser.lastName
             self.lblEmail.text       = currentUser.email
             self.lblMobileNo.text    = currentUser.mobileNo
             self.lbldob.text         = currentUser.dob
             self.lblContry.text      = currentUser.country
             self.lblState.text       = currentUser.state
             self.lblCity.text        = currentUser.city
             self.lblGender.text      = currentUser.gender ?? true ? "Male" : "Female"
             self.lblAboutMe.text     = currentUser.about
             
             if let imageUrlString = currentUser.image {
                 let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                 let imageUrl = documentsDirectory.appendingPathComponent(imageUrlString)

                 if FileManager.default.fileExists(atPath: imageUrl.path) {
                     
                     do {
                         let imageData = try Data(contentsOf: imageUrl)
                         if let image = UIImage(data: imageData) {
                             
                             self.imgProfile.image = image
                         } else {
                             
                             print("Error creating UIImage from image data.")
                             self.imgProfile.image = UIImage(named: "imgProfile")
                         }
                     } catch {
     
                         print("Error loading image data: \(error.localizedDescription)")
                         self.imgProfile.image = UIImage(named: "imgProfile")
                     }
                 } else {
    
                     print("Image file does not exist at path: \(imageUrl.path)")
                     self.imgProfile.image = UIImage(named: "imgProfile")
                 }
             } else {
                 
                 self.imgProfile.image = UIImage(named: "imgProfile")
             }
         }
     }
    
    func logOut() {
        
        DatabaseManager.shared.logOutCurrentUser()
        
//      Set user default for logout
        UserDefaults.standard.setLoginFlag(isLoggedIn: false)
        
        // Check login flag and navigate
        if UserDefaults.standard.getLoginFlag() == false {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        print("User logout successfully.")
    }
    
    //-----------------------------------------
    
    //MARK: Action
    
    @IBAction func btnLogOutClick(_ sender: Any) {
        
        self.logOut()

    }
    
    //-----------------------------------------
    
    //MARK: Life-Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width / 2
        self.btnLogOut.layer.cornerRadius  = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem?.isHidden = true
        self.navigationItem.hidesBackButton = true
    }
}
