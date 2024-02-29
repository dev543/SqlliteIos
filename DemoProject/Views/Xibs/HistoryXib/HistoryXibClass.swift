//
//  HistoryXibClass.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 16/01/24.
//

import UIKit

class HistoryXibClass: UITableViewCell {

    //MARK: - Outlates

    @IBOutlet weak var imgProfile  : UIImageView!
    
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
        
        self.imgProfile.layer.cornerRadius = 10
        self.lblTitle.isHidden = false
        
        self.vwMain.addSubview(imgProfile)
        self.imgProfile.translatesAutoresizingMaskIntoConstraints = false
        self.imgProfile.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.imgProfile.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.imgProfile.topAnchor.constraint(equalTo: self.vwMain.topAnchor, constant: 10).isActive = true
    }

    //confing Function

    func confing(_ history: HistoryModel) {
        
        self.imgProfile.image = UIImage(named: history.image ?? "")
        self.lblName.text  = history.name
        self.lblTitle.text = history.title
        self.lblDate.text  = history.date

        if let imageUrl = URL(string: history.image ?? "") {
            
            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                guard let self = self else { return }

                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }

                if let imageData = data {
                    DispatchQueue.main.async {
                        self.imgProfile.image = UIImage(data: imageData)
                    }
                }
            }.resume()
        }
        
        if history.date == "" {
            self.lblTitle.isHidden = true
        }else{
            self.lblTitle.isHidden = false
        }
        
//        if history.image == AppMessages.imgLocation {
//
//            self.vwMain.addSubview(imgProfile)
//            self.imgProfile.translatesAutoresizingMaskIntoConstraints = false
//            self.imgProfile.widthAnchor.constraint(equalToConstant: 50).isActive = true
//            self.imgProfile.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            self.imgProfile.topAnchor.constraint(equalTo: self.vwMain.topAnchor, constant: 10).isActive = true

//        }else{
//
//            self.imgProfile.widthAnchor.constraint(equalToConstant: 50).isActive  = false
//            self.imgProfile.heightAnchor.constraint(equalToConstant: 50).isActive = false
//
//
//            self.vwMain.addSubview(imgProfile)
//            self.imgProfile.translatesAutoresizingMaskIntoConstraints = false
//            self.imgProfile.widthAnchor.constraint(equalToConstant: 80).isActive = true
//            self.imgProfile.heightAnchor.constraint(equalToConstant: 80).isActive = true
//            self.imgProfile.topAnchor.constraint(equalTo: self.vwMain.topAnchor, constant: 10).isActive = true
//        }
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
