//
//  SplashVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 31/01/24.
//

import UIKit

class SplashVC: UIViewController {

    //MARK: Outlate
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var vwMain: UIView!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup() {
        self.applyTheme()
    }
    
    func applyTheme() {
    
        self.image.image = UIImage(named: AppMessages.imgLogoImg)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateToNextScreen()
        }
    }
    
    func navigateToNextScreen() {
        
        let isLogin = UserDefaults.standard.getLoginFlag()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if isLogin {
            
            let venueDataVC = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(venueDataVC, animated: true)
            
        } else {
            
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
   
    //-----------------------------------------
    
    //MARK: Action
    
    //-----------------------------------------
    
    //MARK: Life-Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setup()
    }

}
