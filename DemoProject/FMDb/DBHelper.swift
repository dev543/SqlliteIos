//
//  DBHelper.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 18/01/24.
//

import FMDB
class DBHelper {
    
    static let shared: DBHelper = DBHelper()
    
    func insertVenue(venue: VenueModel) {
        
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return
        }

        database.open()

        do {
            try database.executeUpdate("INSERT INTO venues (name, category, latitude, longitude) VALUES (?, ?, ?, ?)",
            values: [venue.name ?? "", venue.category ?? "", venue.latitude ?? 0.0, venue.longitude ?? 0.0])
            print("Venue data inserted into the database")
        } catch {
            print("Error inserting venue data: \(error)")
        }

        database.close()
    }
    
    //method to insert items into the History table
    func insertHistoryItem(history: HistoryModel) {
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return
        }

        if !database.open() {
            print("Unable to open the database")
            return
        }

        do {
            
            try database.executeUpdate("INSERT INTO History (id, image, name, title, date, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?)",
            values: [history.id ?? 0, history.image ?? "", history.name ?? "", history.title ?? "", history.date ?? "", history.latitude ?? 0.0, history.longitude ?? 0.0])
            print("Item restored to 'History' table in the database")
        } catch {
            print("Error restoring item to 'History' table: \(error.localizedDescription)")
        }

        database.close()
    }
    
    //method to insert items into the History table
    func insertHistory(history: HistoryModel) {
        
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return
        }

        database.open()

        do {
            try database.executeUpdate("INSERT INTO History (image, name, title, date, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?)",
                values: [history.image ?? "", history.name ?? "", history.title ?? "", history.date ?? "", history.latitude ?? 0.0, history.longitude ?? 0.0])

            print("History data inserted into the database")
        } catch {
            print("Error inserting History data: \(error)")
        }

        database.close()
    }
    
    // insert items into the Delete table
    func insertDeleteIteam(history: HistoryModel) {
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return
        }

        if !database.open() {
            print("Unable to open the database")
            return
        }

        do {
            try database.executeUpdate("INSERT INTO [Delete] (image, name, title, date, latitude, longitude, id) VALUES (?, ?, ?, ?, ?, ?, ?)",
            values: [history.image ?? "", history.name ?? "", history.title ?? "", history.date ?? "", history.latitude ?? 0.0, history.longitude ?? 0.0, history.id ?? 0])

            print("History data inserted into the 'Delete' database")
        } catch {
            print("Error inserting History data: \(error)")
        }

        database.close()
    }
   
    //deleteHistoryItem
    
    func deleteHistoryItem(_ item: HistoryModel) {
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return
        }

        if !database.open() {
            print("Unable to open the database")
            return
        }

        do {
    
            try database.executeUpdate("DELETE FROM History WHERE id = ?", values: [item.id ?? 0])
            print("Item removed from 'History' table in the database")
        } catch {
            print("Error removing item from 'History' table: \(error.localizedDescription)")
        }

        database.close()
    }
    
    // removeDeletedItem in DatabaseManager
    func removeDeletedItem(_ item: HistoryModel) {
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return
        }

        if !database.open() {
            print("Unable to open the database")
            return
        }

        do {
            try database.executeUpdate("DELETE FROM [Delete] WHERE id = ?", values: [item.id ?? 0])
            print("Item removed from 'Delete' table in the database")
        } catch {
            print("Error removing item: \(error.localizedDescription)")
        }

        database.close()
    }
    
    //  histry deleted data override
    
    func updateHistoryItem(history: HistoryModel) {
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return
        }

        if !database.open() {
            print("Unable to open the database")
            return
        }

        let updateQuery = "UPDATE History SET date = ? WHERE name = ?"

        do {
            try database.executeUpdate(updateQuery, values: [history.date ?? "", history.name ?? ""])
            print("History item updated in the database")
        } catch {
            print("Error updating history item: \(error.localizedDescription)")
        }

        database.close()
    }
    
    // Check if item with a given name already exists in History table
       func isItemInHistory(name: String) -> Bool {
           guard let database = DatabaseManager.shared.database else {
               print("Database not initialized")
               return false
           }

           if !database.open() {
               print("Unable to open the database")
               return false
           }

           let selectQuery = "SELECT COUNT(*) FROM History WHERE name = ?"

           do {
               let resultSet = try database.executeQuery(selectQuery, values: [name])
               if resultSet.next() {
                   let count = resultSet.int(forColumnIndex: 0)
                   return count > 0
               }
           } catch {
               print("Error checking if item exists in 'History' table: \(error.localizedDescription)")
           }
 
           database.close()
           return false
       }
       
    // insert items into the post table
    func insertPost(post: PostModel) {
        
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return
        }

        if !database.open() {
            print("Unable to open the database")
        }

        do {
            try database.executeUpdate("INSERT INTO post (id, name, title, details, image, isSelect) VALUES (?, ?, ?, ?, ?, ?)", values: [post.id ?? "",post.name ?? "", post.title ?? "", post.details ?? "", post.image ?? "", post.isSelcted ?? ""])
            print("Post data inserted into the database")
        } catch {
            print("Error inserting post data: \(error)")
        }

        database.close()
    }

}

