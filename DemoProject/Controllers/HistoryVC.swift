//
//  HistoryVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 16/01/24.
//

import UIKit

class HistoryVC: UIViewController {

    //MARK: Outlate
    
    @IBOutlet weak var lblHistory   : UILabel!
    @IBOutlet weak var tblHistory   : UITableView!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    var arrSelectedData: [HistoryModel] = []
    
    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup(){
        self.applyTheme()
        self.update()
    }
    
    func applyTheme(){
        
        self.tblHistory.delegate    = self
        self.tblHistory.dataSource  = self
        
        let cellNib = UINib(nibName: "HistoryXib", bundle: nil)
        self.tblHistory.register(cellNib, forCellReuseIdentifier: "HistoryXibClass")
        
    }
    
    func update() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.arrSelectedData = DatabaseManager.shared.getSelectedData()
            self.arrSelectedData.reverse()
            self.tblHistory.reloadData()
        }
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
        self.update()
        
        self.navigationController?.isNavigationBarHidden = true
//        self.navigationItem.leftBarButtonItem?.isHidden = true
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear History")
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource methods

extension HistoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSelectedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCell  = tableView.dequeueReusableCell(withIdentifier: "HistoryXibClass", for: indexPath) as! HistoryXibClass
        objCell.confing(self.arrSelectedData[indexPath.row])
        return objCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let seletedDetail = self.arrSelectedData[indexPath.row]
        
        if seletedDetail.latitude == 0.0 && seletedDetail.longitude == 0.0 {
            // Navigate to the Detail screen
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            
            detailVC.jobTitleFlage = seletedDetail.name
            detailVC.detailsFlage = seletedDetail.title
            detailVC.imageFlage = seletedDetail.image
            detailVC.nameFlage  = seletedDetail.name
         
            self.navigationController?.pushViewController(detailVC, animated: true)

        }else {
            // Navigate to the map screen
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let mapVC = storyBoard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
            mapVC.latitudeFlag  = seletedDetail.latitude
            mapVC.longitudeFlag = seletedDetail.longitude
            mapVC.locationName  = seletedDetail.name
            self.navigationController?.pushViewController(mapVC, animated: true)

        }
    }
 
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }

            let selectedHistory = self.arrSelectedData[indexPath.row]
            
            // method to insert items into the Delete table
            DBHelper.shared.insertDeleteIteam(history: HistoryModel(
                id: selectedHistory.id,
                image: selectedHistory.image ?? "",
                name: selectedHistory.name ?? "",
                title: selectedHistory.title ?? "",
                date: selectedHistory.date ?? "",
                latitude: selectedHistory.latitude ?? 0.0,
                longitude: selectedHistory.longitude ?? 0.0
                
            ))
            
            // delete items from the History table
            DBHelper.shared.deleteHistoryItem(selectedHistory)

            self.arrSelectedData.remove(at: indexPath.row)
            self.tblHistory.deleteRows(at: [indexPath], with: .fade)

            completionHandler(true)
        }

        deleteAction.backgroundColor = .red

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
} 

//-----------------------------------------------------
