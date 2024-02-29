//
//  pXibClass.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 31/01/24.
//

import UIKit
import SwiftyJSON
import FSPagerView

class PXibClass: UITableViewCell {

    //MARK: - Outlates
    
    @IBOutlet weak var imgProfile   : UIImageView!
    @IBOutlet weak var colImages    : UICollectionView!
    
    @IBOutlet weak var lblName      : UILabel!
    @IBOutlet weak var lblTitle     : UILabel!
    @IBOutlet weak var lblLikesCount: UILabel!
    
    @IBOutlet weak var btnLike      : UIButton!
    @IBOutlet weak var btnSave      : UIButton!
    
    @IBOutlet weak var vwFsPagerView: UIView!
    
    //-----------------------------------------
    //MARK: - Custom Variables
    
    let arrImages : [String] = ["pexels1","pexels2","pexels4"]
    
    private var pageController = FSPageControl(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
    
    //-----------------------------------------
    
    //MARK: - Custom Methods
    
    func setupView() {
        self.applyTheme()
        
    }
    
    func applyTheme() {
        
        self.colImages.dataSource = self
        self.colImages.delegate   = self
        
        self.lblLikesCount.text = AppMessages.likeByDemoAnd
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.width / 2
        
        let cellNib = UINib(nibName: "FSPagerImageXib", bundle: nil)
        self.colImages.register(cellNib, forCellWithReuseIdentifier: "FSPagerImageXibClass")
        
        self.pageController.setImage(UIImage(named:"Oval1"), for: .normal)
        self.pageController.setImage(UIImage(named:"Oval2"), for: .selected)
        self.pageController.itemSpacing = 10
        self.pageController.numberOfPages = self.arrImages.count
        self.vwFsPagerView.addSubview(self.pageController)
        
    }

    //confing Function
    
    func confing(_ json: JSON) {
        self.lblName.text = json["celebName"].stringValue
        self.lblTitle.text = json["celebJobTitle"].stringValue
        
        let imageUrl = URL(string: json["celebImageUrl"].string ?? "")
        self.imgProfile.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""))
        
    }

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

extension PXibClass: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let objCell  = collectionView.dequeueReusableCell(withReuseIdentifier: "FSPagerImageXibClass", for: indexPath) as! FSPagerImageXibClass
        objCell.confing(self.arrImages[indexPath.item])
        return objCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return colImages.frame.size
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let curruntPage = scrollView.contentOffset.x / view.frame.width
//        self.pageController.currentPage = Int(curruntPage)
//
//    }
}
