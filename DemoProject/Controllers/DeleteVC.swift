//
//  DeleteVC.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 18/01/24.
//

import UIKit

class DeleteVC: UIViewController {
    
    //MARK: Outlate
    
    @IBOutlet weak var lblDelete    : UILabel!
    @IBOutlet weak var tblDelete    : UITableView!
    @IBOutlet weak var loader       : UIActivityIndicatorView!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    var arrDeletedData: [HistoryModel] = []
    
    var arrHistoryData: [HistoryModel] = []
    
    //-----------------------------------------
    
    //MARK: Custom Method
    
    func setup(){
        self.applyTheme()
        self.update()
    }
    
    func applyTheme(){
        
        self.lblDelete.text = AppMessages.delete
        
        self.tblDelete.delegate   = self
        self.tblDelete.dataSource = self
        
        let cellNib = UINib(nibName: "HistoryXib", bundle: nil)
        self.tblDelete.register(cellNib, forCellReuseIdentifier: "HistoryXibClass")
        
    }
    
    func update() {
        
        self.loader.isHidden = false
        self.loader.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.arrDeletedData = DatabaseManager.shared.getDeleteData()
            self.arrDeletedData.reverse()
            self.tblDelete.reloadData()
            self.loader.isHidden = true
            self.loader.stopAnimating()
        }
    }
    
    func deleteHistoryItem(_ item: HistoryModel) {
        
        self.arrDeletedData.append(item)

        guard let index = self.arrHistoryData.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        self.arrHistoryData.remove(at: index)
    }
   
    func showOverwriteAlert(for historyItem: HistoryModel, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "", message: AppMessages.alreadyExistsInHistory, preferredStyle: .alert)

        let overwriteAction = UIAlertAction(title: AppMessages.overwrite, style: .destructive) { _ in
  
               completionHandler(true)
           }

        let cancelAction = UIAlertAction(title: AppMessages.cancel, style: .cancel) { _ in
               completionHandler(false)
           }

           alert.addAction(overwriteAction)
           alert.addAction(cancelAction)

           self.present(alert, animated: true, completion: nil)
       }
    
    //-----------------------------------------
    
    //MARK: Action
    
    
    //-----------------------------------------
    
    //MARK: Life-Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.update()
        
        self.navigationController?.isNavigationBarHidden = true
        if #available(iOS 16.0, *) {
            self.navigationItem.leftBarButtonItem?.isHidden = true
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.hidesBackButton = true
    }

}

//-----------------------------------------
//MARK: - UITableViewDelegate, UITableViewDataSource

extension DeleteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDeletedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCell = tableView.dequeueReusableCell(withIdentifier: "HistoryXibClass", for: indexPath) as! HistoryXibClass
        objCell.confing(self.arrDeletedData[indexPath.row])
        return objCell
    }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let permanentDeleteAction = UIContextualAction(style: .destructive, title: "Permanent Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }

            let deletedItem = self.arrDeletedData.remove(at: indexPath.row)
            DBHelper.shared.removeDeletedItem(deletedItem)

            self.tblDelete.deleteRows(at: [indexPath], with: .fade)

            completionHandler(true)
        }

        permanentDeleteAction.backgroundColor = .red
        
        let restoreAction = UIContextualAction(style: .normal, title: "Restore") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }

            let indexPath = IndexPath(row: indexPath.row, section: 0)
            let restoredItem = self.arrDeletedData[indexPath.row]

            if DBHelper.shared.isItemInHistory(name: restoredItem.name ?? "") {

                self.showOverwriteAlert(for: restoredItem) { shouldOverwrite in
                    if shouldOverwrite {

                        DBHelper.shared.updateHistoryItem(history: restoredItem)
                        DBHelper.shared.removeDeletedItem(restoredItem)
                        
                        self.arrDeletedData.remove(at: indexPath.row)
                        
                        DispatchQueue.main.async {
                            self.tblDelete.reloadData()
                        }
                    }
                }
            } else {
      
                DBHelper.shared.insertHistoryItem(history: restoredItem)
                DBHelper.shared.removeDeletedItem(restoredItem)
                self.arrDeletedData.remove(at: indexPath.row)
                
                DispatchQueue.main.async {
                    self.tblDelete.reloadData()
                }
            }

            completionHandler(true)
        }

        restoreAction.backgroundColor = .blue

        let configuration = UISwipeActionsConfiguration(actions: [permanentDeleteAction, restoreAction])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
}

//-----------------------------------------
