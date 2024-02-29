//
//  SignUpVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 12/01/24.
//

import UIKit
import IQKeyboardManagerSwift
import VisionKit

class SignUpVC: UIViewController {
    
    //MARK: Outlate
    
    @IBOutlet weak var imgProfile   : UIImageView!
    
    @IBOutlet weak var lblSignUp    : UILabel!
    @IBOutlet weak var lblOr        : UILabel!
    
    @IBOutlet weak var txtFirstName : UITextField!
    @IBOutlet weak var txtLastName  : UITextField!
    @IBOutlet weak var txtEmail     : UITextField!
    @IBOutlet weak var txtPassword  : UITextField!
    @IBOutlet weak var txtMobileNo  : UITextField!
    @IBOutlet weak var txtDob       : UITextField!
    @IBOutlet weak var txtContry    : UITextField!
    @IBOutlet weak var txtState     : UITextField!
    @IBOutlet weak var txtCity      : UITextField!
    @IBOutlet weak var tvAbout      : IQTextView!
    
    @IBOutlet weak var vwContry     : UIView!
    @IBOutlet weak var vwState      : UIView!
    @IBOutlet weak var vwCity       : UIView!
    
    @IBOutlet weak var btnMale             : UIButton!
    @IBOutlet weak var btnFemale           : UIButton!
    @IBOutlet weak var btnCreateAccount    : UIButton!
    @IBOutlet weak var btnSignIn           : UIButton!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    var imagePicker  = UIImagePickerController()
    var profileImage = false
    var imageURlFlage: String = ""
    
    let countryPicker   = UIPickerView()
    let statePicker     = UIPickerView()
    let cityPicker      = UIPickerView()
    
    var selectedCountry : String?
    var selectedState   : String?
    var selectedCity    : String?
    
    let datePicker      = UIDatePicker()
    let dateFormatter   = DateFormatter()
    
    var arrLocations: [LocationModel] = [
        LocationModel(country: "USA", states: [
            StateModel(name: "Alaska", cities: ["Anchorage","Cordova","Fairbanks","Homer","Juneau","Ketchikan","Kodiak"]),
            StateModel(name: "California", cities: ["Alameda","Alhambra","Anaheim","Los Angeles","San Francisco"]),
            StateModel(name: "New York", cities: ["Albany","Beacon","Buffalo","Clinton","Coney Island","Dunkirk","New York City",]),
            
        ]),
        
        LocationModel(country: "Canada", states: [
            StateModel(name: "Alberta", cities: ["Airdrie","Beaumont","Camrose","Lacombe","Leduc","Wetaskiwin"]),
            StateModel(name: "Nunavut", cities: ["Barrie","Burlington","Elliot Lake","Guelph","Kenora","Kingston", "London"]),
            StateModel(name: "Ontario", cities: ["Brampton","Brant","Brockville","Clarence-Rockland","Cornwall","Toronto", "Ottawa"]),
            StateModel(name: "Quebec", cities: ["Estevan","Humboldt","Meadow Lake","Moose Jaw","Prince Albert","Montreal", "Quebec City"]),
        ]),
        
    ]

    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup(){
        self.applyTheme()
        self.emptyTextField()
    }
    
    func applyTheme(){
        
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationItem.leftBarButtonItem?.isHidden = true
        self.navigationItem.hidesBackButton = true
        
        self.txtDob.inputView = self.datePicker
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.datePickerMode = .date
        
        self.countryPicker.delegate     = self
        self.countryPicker.dataSource   = self
        self.txtContry.inputView        = self.countryPicker

        self.statePicker.delegate       = self
        self.statePicker.dataSource     = self
        self.txtState.inputView         = self.statePicker

        self.cityPicker.delegate        = self
        self.cityPicker.dataSource      = self
        self.txtCity.inputView          = self.cityPicker

        self.txtFirstName.delegate = self
        self.txtLastName.delegate  = self
        self.txtDob.delegate       = self
        self.txtEmail.delegate     = self
        self.txtPassword.delegate  = self
        self.txtMobileNo.delegate  = self
        self.txtContry.delegate    = self
        self.txtCity.delegate      = self
        self.txtState.delegate     = self
        
        self.lblSignUp.text      = AppMessages.signUp
        self.lblSignUp.textColor = UIColor.purple
        self.lblSignUp.font      = UIFont.systemFont(ofSize: 40.0)
        
        self.lblOr.text      = AppMessages.or
        self.lblOr.textColor = UIColor.black
        
        self.tvAbout.layer.cornerRadius = 10
        self.tvAbout.layer.borderWidth  = 1
        self.tvAbout.layer.borderColor  = UIColor.gray.cgColor
        
        self.tvAbout.font   = UIFont.systemFont(ofSize: 20.0)
        self.txtCity.font   = UIFont.systemFont(ofSize: 20.0)
        self.txtContry.font = UIFont.systemFont(ofSize: 20.0)
        self.txtState.font  = UIFont.systemFont(ofSize: 20.0)
        
        self.txtPassword.isSecureTextEntry = true
        
        self.txtFirstName.placeHolder(placeholder: AppMessages.firstName, font: UIFont.systemFont(ofSize: 25.0))
        self.txtLastName.placeHolder(placeholder: AppMessages.lastName, font: UIFont.systemFont(ofSize: 25.0))
        self.txtEmail.placeHolder(placeholder: AppMessages.email, font: UIFont.systemFont(ofSize: 25.0))
        self.txtPassword.placeHolder(placeholder: AppMessages.password, font: UIFont.systemFont(ofSize: 25.0))
        self.txtMobileNo.placeHolder(placeholder: AppMessages.mobileNo, font: UIFont.systemFont(ofSize: 25.0))
        self.txtDob.placeHolder(placeholder: AppMessages.dob, font: UIFont.systemFont(ofSize: 25.0))
        self.txtContry.placeHolder(placeholder: AppMessages.country, font: UIFont.systemFont(ofSize: 25.0))
        self.txtState.placeHolder(placeholder: AppMessages.state, font: UIFont.systemFont(ofSize: 25.0))
        self.txtCity.placeHolder(placeholder: AppMessages.city, font: UIFont.systemFont(ofSize: 25.0))
        self.tvAbout.addPlaceholder(AppMessages.aboutMe, font: UIFont.systemFont(ofSize: 20.0), textColor: .lightGray, textAlignment: .center)

        self.btnSignIn.setTitle(AppMessages.signIn, for: .normal)
        self.btnSignIn.titleLabel?.textColor = UIColor.purple
        
        self.btnCreateAccount.backgroundColor = UIColor.purple
        self.btnCreateAccount.titleLabel?.textColor = UIColor.white
        
        self.selectedCountry = self.arrLocations.first?.country
        self.selectedState   = self.arrLocations.first?.states.first?.name
        self.selectedCity    = self.arrLocations.first?.states.first?.cities.first
        
        self.statePicker.reloadAllComponents()
        self.cityPicker.reloadAllComponents()
        
        self.imagePicker.delegate = self
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width / 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.imgProfile.addGestureRecognizer(tap)
        
        self.datePicker.addTarget(self, action: #selector(self.setDate), for: .valueChanged)
        
    }
    
    @objc func setDate(){
        print("date")
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
        self.datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        self.txtDob.text = dateFormatter.string(from: self.datePicker.date)
        self.view.endEditing(true)
    }
    
//    func analyzeImage(){
//
//        if let image = imgProfile {
//            Task {
//                let confi = ImageAnalyzer.Configuration([.text,.machineReadableCode])
//                do{
//                    let analysis = try await analyzeIm
//                }
//            }
//        }
//    }

    //select image method
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.openSheet()
    }
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                controller.addAction(action)
                return controller
            }()
            self.present(alertController, animated: true)
        }
    }
    
    func openGallery(){
        
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func openSheet() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            action in
            
            self.openCamera()
            
        }
        let galleryAction = UIAlertAction(title: "Photo Library", style: .default){
            action in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            action in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    // Function generate a unique name based on date and time
    func generateUniqueName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let currentDateTime = Date()
        return "image_\(dateFormatter.string(from: currentDateTime)).jpg"
    }

    func saveData(_ modelInfo: UserModel, imageName: String) -> Bool {
        DatabaseManager.shared.openDatabase()

        // Check if the email already exists
        if DatabaseManager.shared.isEmailAlreadyExists(email: modelInfo.email!) {
            DatabaseManager.shared.closeDatabase()
            self.txtEmail.text = ""
            GlobalFunction.shared.showAlert(message: AppMessages.emailAlreadyExists, from: self)
            return false
        }

        let isSave = DatabaseManager.shared.database.executeUpdate("INSERT INTO Signup (fname, lname, email, password, mobileno, dob, country, state, city, gender, aboutme, image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", withArgumentsIn: [
            modelInfo.firstName!, modelInfo.lastName!, modelInfo.email!, modelInfo.password!, modelInfo.mobileNo!, modelInfo.dob!, modelInfo.country!, modelInfo.state!, modelInfo.city!, modelInfo.gender!, modelInfo.about!, imageName
        ])

        DatabaseManager.shared.closeDatabase()
        return isSave
    }

    func emptyTextField(){
        
        self.txtFirstName.text      = ""
        self.txtLastName.text       = ""
        self.txtEmail.text          = ""
        self.txtPassword.text       = ""
        self.txtMobileNo.text       = ""
        self.txtDob.text            = ""
        self.txtContry.text         = ""
        self.txtState.text          = ""
        self.txtCity.text           = ""
        self.tvAbout.text           = ""
    }
    
    // validFunction
    func valid() -> String? {
        
        guard self.profileImage == true else{
            return AppMessages.emptyImage
        }
        guard !self.txtFirstName.text!.isEmpty else{
            return AppMessages.emptyFirstName
        }
        guard self.txtFirstName.isValidFirstName(testStr: self.txtFirstName.text ?? "") else{
            return AppMessages.validMsgFirstName
        }
        guard !self.txtLastName.text!.isEmpty else{
            return AppMessages.emptyLastName
        }
        guard self.txtLastName.isValidFirstName(testStr: self.txtLastName.text ?? "") else{
            return AppMessages.validMsgLastName
        }
        guard !self.txtEmail.text!.isEmpty else{
            return AppMessages.emptyEmail
        }
        guard self.txtEmail.isValidEmail(testStr: self.txtEmail.text ?? "") else{
            return AppMessages.validMsgEmail
        }
        guard !self.txtPassword.text!.isEmpty else{
            return AppMessages.emptyPassword
        }
        guard !self.txtMobileNo.text!.isEmpty else{
            return AppMessages.emptyMobileNumber
        }
        guard self.txtMobileNo.text!.count >= 8 else{
            return AppMessages.validMsgMobileNumber
        }
        guard !self.txtDob.text!.isEmpty else{
            return AppMessages.emptyDob
        }
        guard !self.txtContry.text!.isEmpty else{
            return AppMessages.emptyContry
        }
        guard !self.txtState.text!.isEmpty else{
            return AppMessages.emptyState
        }
        guard !self.txtCity.text!.isEmpty else{
            return AppMessages.emptyCity
        }
        guard self.btnMale.isSelected || self.btnFemale.isSelected else{
            return AppMessages.emptyGender
        }
        guard !self.tvAbout.text!.isEmpty else{
            return AppMessages.emptyAbout
        }
        return nil
    }
    
    //-----------------------------------------
    
    //MARK: Action
    
    @IBAction func btnMaleClick(_ sender: Any) {
        self.btnMale.isSelected   = true
        self.btnFemale.isSelected = false
    }
    
    @IBAction func btnFemaleClick(_ sender: Any) {
        self.btnFemale.isSelected = true
        self.btnMale.isSelected   = false
    }
    
    @IBAction func btnCreateAccountClick(_ sender: Any) {
        
        if let error = valid() {
            GlobalFunction.shared.showAlert(message: error, from: self)

        }else{
            
            let user = UserModel(
                     id         : 0,
                     image      : "\(imageURlFlage)",
                     firstName  : self.txtFirstName.text ?? "",
                     lastName   : self.txtLastName.text ?? "",
                     email      : self.txtEmail.text ?? "",
                     password   : self.txtPassword.text ?? "",
                     mobileNo   : self.txtMobileNo.text ?? "",
                     dob        : self.txtDob.text ?? "",
                     country    : self.txtContry.text ?? "",
                     state      : self.txtState.text ?? "",
                     city       : self.txtCity.text ?? "",
                     about      : self.tvAbout.text ?? "",
                     gender     : self.btnMale.isSelected ? true : (self.btnFemale.isSelected ? false : nil)
                 )
            
            let imageName = "\(imageURlFlage)"
            let isSave = self.saveData(user, imageName: imageName)

            print(isSave)

            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnSignInClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //-----------------------------------------
    
    //MARK: Life-Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.vwContry.customeTheme()
        self.vwCity.customeTheme()
        self.vwState.customeTheme()
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width / 2
        self.btnCreateAccount.layer.cornerRadius = 20
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }

}

//-----------------------------------------

//MARK: - TextField delegate methos

extension SignUpVC : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if self.txtContry == textField {
            self.txtContry.text = self.selectedCountry
        }
        
        if self.txtState == textField {
            self.txtState.text = self.selectedState
        }
        
        if self.txtCity == textField {
            self.txtCity.text = self.selectedCity
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                print("Backspace was pressed")
                return true
            }
        }
        
        if self.txtFirstName == textField{
            return self.txtFirstName.isValidFirstName(testStr: string)
        }
        
        if self.txtLastName == textField{
            return self.txtLastName.isValidFirstName(testStr: string)
        }
        
        if self.txtMobileNo == textField {
            if range.location <= 0 && string == " "{
                return false
            }else if self.txtMobileNo.text!.count < 10 || string == " " {
                return self.txtMobileNo.isValidContectNo(testStr:string)
            }
            return false
        }
        
        if self.txtPassword == textField {
            if range.location <= 0 && string == " "{
                return false
            }else if string == " "{
                return false
            }
            return true
        }

        if self.txtDob == textField {
            return false
        }
        
        if self.txtContry == textField {
            return false
        }

        if self.txtState == textField {
            return false
        }

        if self.txtCity == textField {
            return false
        }
        
        debugPrint("shouldChangeCharactersIn")
        return true
    }
}
//-----------------------------------------

//MARK: - UIImagePickerControllerDelegate

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            let uniqueName = self.generateUniqueName()
            self.imageURlFlage = uniqueName
            // saveImage the image with the unique name
            if let imageUrl = self.saveImage(image: image, imageName: uniqueName) {
                
                print("Image saved with unique name: \(imageUrl)")

                self.profileImage = true
                self.imagePicker.dismiss(animated: true)
            } else {
                print("Failed to save the image.")
            }
        } else {
            print("Failed to get the image from the photo library.")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        self.imagePicker.dismiss(animated: true)
    }
    
    // Function to save the image with the given name
    func saveImage(image: UIImage, imageName: String) -> URL? {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        print(documentsDirectory)
        
        let imageUrl = documentsDirectory.appendingPathComponent(imageName,isDirectory: true)
        
        do {
            
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: imageUrl)
                self.imgProfile.image = UIImage(contentsOfFile: imageUrl.path)
//                self.imageURlFlage = imageUrl.path
                return imageUrl
            } else {
                return nil
            }
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
}

//---------------------------------------------------

//MARK: - UIPickerViewDelegate,UIPickerViewDataSource Methods

extension SignUpVC : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
  
        if pickerView == self.countryPicker {
            return self.arrLocations.count
        } else if pickerView == self.statePicker {
            guard let selectedCountry = self.selectedCountry,
                  let location = self.arrLocations.first(where: { $0.country == selectedCountry }) else {
                return 0
            }
            return location.states.count
        } else if pickerView == self.cityPicker {
            guard let selectedCountry = self.selectedCountry,
                  let selectedState = self.selectedState,
                  let location = self.arrLocations.first(where: { $0.country == selectedCountry }),
                  let state = location.states.first(where: { $0.name == selectedState }) else {
                return 0
            }
            return state.cities.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                
        if pickerView == self.countryPicker {
            
            return self.arrLocations[row].country
            
        } else if pickerView == self.statePicker {
            
            guard let selectedCountry = self.selectedCountry,
                  let location = self.arrLocations.first(where: { $0.country == selectedCountry }) else {
                return nil
            }
            
            return location.states[row].name
            
        } else if pickerView == self.cityPicker {
            
            guard let selectedCountry = self.selectedCountry,
                  let selectedState   = self.selectedState,
                  let location = self.arrLocations.first(where: { $0.country == selectedCountry }),
                  let state = location.states.first(where: { $0.name == selectedState }) else {
                return nil
            }
            
            return state.cities[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.countryPicker {
            
            self.txtState.text   = ""
            self.txtCity.text    = ""
            self.selectedCountry = self.arrLocations[row].country
            self.selectedState   = self.arrLocations[row].states[0].name
            self.selectedCity    = self.arrLocations[row].states[0].cities[0]
            self.txtContry.text  = self.selectedCountry
            self.statePicker.reloadAllComponents()
            self.cityPicker.reloadAllComponents()
    
//            self.view.endEditing(true)
            
        } else if pickerView == self.statePicker {
            
            self.txtCity.text = ""
            guard let selectedCountry = self.selectedCountry else { return }
            self.selectedState = self.arrLocations.first(where: { $0.country == selectedCountry })?.states[row].name
            self.selectedCity = self.arrLocations.first(where: { $0.country == selectedCountry })?.states[row].cities.first ?? ""
            self.txtState.text = self.selectedState
//            self.view.endEditing(true)
            self.cityPicker.reloadAllComponents()
            
        } else if pickerView == self.cityPicker {
            
            guard let selectedCountry = self.selectedCountry,
                  let selectedState = self.selectedState else { return }
            self.selectedCity = self.arrLocations.first(where: { $0.country == selectedCountry })?.states.first(where: { $0.name == selectedState })?.cities[row]
            self.txtCity.text = self.selectedCity
//            self.view.endEditing(true)
        }
    }
}

//---------------------------------------------------
