//
//  PostVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 16/01/24.
//

import UIKit
import SwiftyJSON

class PostVC: UIViewController {
    
    //MARK: Outlate
    
    @IBOutlet weak var tblPost  : UITableView!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    var arrPostData : [String:Any] = [:]
    
    var arrAllData  : [PostModel]  = []

    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup(){
        
        self.applyTheme()
        
        if !UserDefaults.standard.getPostData(){
            self.readJSONFile()
            print("😄😄😄========== Data get FROM JSON File ==========😄😄😄")
        }else{
            self.arrAllData = DatabaseManager.getInstance().readPostData()
            print("😁😁😁====== JSON Data get FROM Database ======😁😁😁")
        }
        
    }
    
    func applyTheme(){
        
        self.tblPost.delegate   = self
        self.tblPost.dataSource = self
        
        let cellNib = UINib(nibName: "PostXib", bundle: nil)
        self.tblPost.register(cellNib, forCellReuseIdentifier: "PostXibClass")
        
    }
    
    func readJSONFile() {
       do {
          if let bundlePath = Bundle.main.path(forResource: "user", ofType: "json"),
          let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] {
//                print("JSON: \(json)")
                 self.arrPostData = json
                 self.setData()
             } else {
                print("Given JSON is not a valid dictionary object.")
             }
          }
       } catch {
          print(error)
       }
    }
     
    func setData() {
        if let jsonArray = self.arrPostData["FaceCelebDetails"] as? [[String: Any]] {
            let postModels: [PostModel] = jsonArray.compactMap { json in
                guard
                    let celebName = json["celebName"] as? String,
                    let celebJobTitle = json["celebJobTitle"] as? String,
                    let details = json["details"] as? String,
                    let celebImageUrl = json["celebImageUrl"] as? String,
                    let isSelect = json["isSelect"] as? String
                else {
                    return PostModel.init(id: 0, name: "", title: "", details: "", image: "", isSelcted: "")
                }

                return PostModel(id: 0, name: celebName, title: celebJobTitle, details: details, image: celebImageUrl, isSelcted: isSelect)
            }
            self.processPosts(posts: postModels)
        } else {
            print("Key 'FaceCelebDetails' not found in the JSON.")
        }
    }
    
    func processPosts(posts: [PostModel]) {
        self.arrAllData = posts
        print("🧐🧐🧐============JSON File Data============🧐🧐🧐")
        for post in posts {
            print("Title: \(post.title ?? "")")
            print("name: \(post.name ?? "")")
            print("details: \(post.details ?? "")")
            print("image: \(post.image ?? "")")
            print("isSelcted: \(post.isSelcted ?? "")")
            DBHelper.shared.insertPost(post: post)
        }
        UserDefaults.standard.setPostData(isJsonData: true)
    }

    //-----------------------------------------
    
    //MARK: Action
    
    //-----------------------------------------
    
    //MARK: Life-Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationItem.leftBarButtonItem?.isHidden  = true
        self.navigationItem.hidesBackButton = true
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource methods

extension PostVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAllData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCell  = tableView.dequeueReusableCell(withIdentifier: "PostXibClass", for: indexPath) as! PostXibClass
        objCell.confing(self.arrAllData[indexPath.row])
       
        return objCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPost = self.arrAllData[indexPath.row]
        DBHelper.shared.insertHistory(history: HistoryModel(
            id: 0 ,
            image: selectedPost.image ?? "",
            name: selectedPost.name ?? "",
            title: selectedPost.details ?? "",
            date: "",
            latitude: 0.0,
            longitude: 0.0
        ))

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        detailVC.jobTitleFlage  = selectedPost.title
        detailVC.detailsFlage   = selectedPost.details
        detailVC.imageFlage     = selectedPost.image
        detailVC.nameFlage      = selectedPost.name

        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//-----------------------------------------------------
