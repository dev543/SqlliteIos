//
//  ViewController.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 12/01/24.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: Outlate
    
    @IBOutlet weak var lblSignIn            : UILabel!
    @IBOutlet weak var lblDontHaveAnAccount : UILabel!
    
    @IBOutlet weak var txtEmail     : UITextField!
    @IBOutlet weak var txtPassword  : UITextField!
    
    @IBOutlet weak var btnLogin     : UIButton!
    @IBOutlet weak var btnSignUp    : UIButton!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    //-----------------------------------------
        
    //MARK: Custom Method
    
    func setup(){
        self.applyTheme()
    }
    
    func applyTheme(){
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        if #available(iOS 16.0, *) {
            self.navigationItem.leftBarButtonItem?.isHidden = true
        } else {
            // Fallback on earlier versions
        }
        
       
        self.txtPassword.isSecureTextEntry = true
        
        self.lblSignIn.text      = AppMessages.signIn
        self.lblSignIn.textColor = UIColor.blue
        self.lblSignIn.font      = UIFont.systemFont(ofSize: 40.0)
        
        self.lblDontHaveAnAccount.text = AppMessages.dontHaveAnAccount
        self.lblDontHaveAnAccount.textColor = UIColor.gray
        
        self.txtEmail.placeHolder(placeholder: AppMessages.email, font: UIFont.systemFont(ofSize: 25.0))
        self.txtPassword.placeHolder(placeholder: AppMessages.password, font: UIFont.systemFont(ofSize: 25.0))
         
    }

    // validFunction
    func valid() -> String? {
        
        guard !txtEmail.text!.isEmpty else{
            return AppMessages.emptyEmail
        }
        guard txtEmail.isValidEmail(testStr: txtEmail.text ?? "") else{
            return AppMessages.validMsgEmail
        }
        guard !txtPassword.text!.isEmpty else{
            return AppMessages.emptyPassword
        }
        return nil
    }

    //-----------------------------------------
    
    //MARK: Action
    
    @IBAction func btnLoginClick(_ sender: Any) {
        
        if let error = valid() {
            GlobalFunction.shared.showAlert(message: error, from: self)

        } else {
            
            let email = self.txtEmail.text ?? ""
            let password = self.txtPassword.text ?? ""
            
          if let retrievedUser = DatabaseManager.getInstance().getUser(withEmail: email, password: password)
            {
              
              DatabaseManager.shared.setCurrentUser(retrievedUser)
              
//            Store email & password in UserDefaults
              UserDefaults.standard.setEmail(isEmail: email)
              UserDefaults.standard.setPassword(isPassword: password)

//            Set user default for login
              UserDefaults.standard.setLoginFlag(isLoggedIn: true)
              
              self.txtEmail.text    = ""
              self.txtPassword.text = ""
              
              let storyBoard = UIStoryboard(name: "Main", bundle: nil)
              let venueDataVC = storyBoard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
              self.navigationController?.pushViewController(venueDataVC, animated: true)

            } else {
                GlobalFunction.shared.showAlert(message: AppMessages.invalidCredentials, from: self)
            }
        }
    }
    
    @IBAction func btnSignUpClick(_ sender: Any) {
        
        print("Sign Up button clicked")
          
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVCScreen = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signUpVCScreen, animated: true)
        
    }
    
    //-----------------------------------------
    
    //MARK: Life-Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.setup()
        
    }
    
    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
        self.btnLogin.layer.cornerRadius  = 20
    }
}

//---------------------------------------------
