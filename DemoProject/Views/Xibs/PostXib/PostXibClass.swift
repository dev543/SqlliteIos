//
//  PostXibClass.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 12/01/24.
//

import UIKit
import SwiftyJSON
import FSPagerView

class PostXibClass: UITableViewCell {

    //MARK: - Outlates
    
    @IBOutlet weak var imgProfile   : UIImageView!
    @IBOutlet weak var imgPost      : UIImageView!
    
    @IBOutlet weak var lblName      : UILabel!
    @IBOutlet weak var lblTitle     : UILabel!
    @IBOutlet weak var lblLikesCount: UILabel!
    
    @IBOutlet weak var btnLike      : UIButton!
    @IBOutlet weak var btnSave      : UIButton!
    
    @IBOutlet weak var vwFsPagerView: UIView!
    
    //-----------------------------------------
    //MARK: - Custom Variables
    
    let arrImages : [String] = ["pexels1","pexels2","pexels4"]
    
    private var pageController = FSPageControl(frame: CGRect(x: 0, y: 0, width: 42, height: 16))
    
    //-----------------------------------------
    
    //MARK: - Custom Methods
    
    func setupView() {
        self.applyTheme()
        
    }
    
    func applyTheme() {
        
        self.lblLikesCount.text = AppMessages.likeByDemoAnd
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width / 2
        
        self.pageController.setImage(UIImage(named:"Oval1"), for: .normal)
        self.pageController.setImage(UIImage(named:"Oval2"), for: .selected)
        self.pageController.itemSpacing = 10
//        self.pageController.numberOfPages = self.arrimage.count
        self.vwFsPagerView.addSubview(self.pageController)
        
    }

    //confing Function
    
    func confing(_ json: PostModel) {
        self.lblName.text = json.name
        self.lblTitle.text = json.title
        
        let imageUrl = URL(string: json.image ?? "")
        self.imgProfile.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""))
        
        //comment code working comment BCZ set img pod install to set img
        
//        if let imageUrlString = json["celebImageUrl"].string, let imageUrl = URL(string: imageUrlString) {
//            // Use URLSession to load the image asynchronously
//            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
//                guard let self = self else { return }
//
//                if let error = error {
//                    print("Error loading image: \(error)")
//                    return
//                }
//
//                if let imageData = data {
//
//                    DispatchQueue.main.async {
//                        self.imgProfile.image = UIImage(data: imageData)
//                    }
//                }
//            }.resume()
//        }
    }
    //confing Function
    
//    func confing(_ json: JSON) {
//        self.lblName.text = json["celebName"].stringValue
//        self.lblTitle.text = json["celebJobTitle"].stringValue
//
//        let imageUrl = URL(string: json["celebImageUrl"].string ?? "")
//        self.imgProfile.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""))
//
//        //comment code working comment BCZ set img pod install to set img
//
////        if let imageUrlString = json["celebImageUrl"].string, let imageUrl = URL(string: imageUrlString) {
////            // Use URLSession to load the image asynchronously
////            URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
////                guard let self = self else { return }
////
////                if let error = error {
////                    print("Error loading image: \(error)")
////                    return
////                }
////
////                if let imageData = data {
////
////                    DispatchQueue.main.async {
////                        self.imgProfile.image = UIImage(data: imageData)
////                    }
////                }
////            }.resume()
////        }
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let curruntPage = scrollView.contentOffset.x / view.frame.width
//        self.pageController.currentPage = Int(curruntPage)
//
//    }
    //----------------------------------------
    
    //MARK: - Actions
    @IBAction func btnLikeClick(_ sender: Any) {
        self.btnLike.isSelected.toggle()
    }
    @IBAction func btnSaveClick(_ sender: Any) {
        self.btnSave.isSelected.toggle()
    }
    
    //----------------------------------------
    
    //MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    //----------------------------------------
    
}
