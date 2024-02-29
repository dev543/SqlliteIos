//
//  DatabaseManager.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 17/01/24.
//

import Foundation
import FMDB

class DatabaseManager: NSObject {
    
    private var currentUser: UserModel?
    
    var database: FMDatabase!
    
    static let shared: DatabaseManager = {
        let instance = DatabaseManager()
        return instance
    }()
    
    func createDatabase() {
        let bundlePath = Bundle.main.path(forResource: "VenueData", ofType: ".db")
        print(bundlePath ?? "", "\n") // prints the correct path
        
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("VenueData.db")
        let fullDestPathString = fullDestPath!.path
        
        print("Database Path : - \(String(describing: fullDestPath))")
        
        if fileManager.fileExists(atPath: fullDestPathString) {
            print("File is available")
            database = FMDatabase(path: fullDestPathString)
            openDatabase()
            print(fullDestPathString)
        } else {
            do {
                try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPathString)
                if fileManager.fileExists(atPath: fullDestPathString) {
                    database = FMDatabase(path: fullDestPathString)
                    openDatabase()
                    print("File is copied")
                } else {
                    print("File is not copied")
                }
            } catch {
                print("\n")
                print(error)
            }
        }
    }
    
    func openDatabase() {
        if database != nil {
            database.open()
        } else {
            createDatabase()
        }
    }
    
    func closeDatabase() {
        if database != nil {
            database.close()
        } else {
            
        }
    }
    
    class func getInstance() -> DatabaseManager {
        let instance = DatabaseManager.shared
        if instance.database == nil {
            instance.database = FMDatabase(path: DatabaseManager.getPath("VenueData.db"))
        }
        return instance
    }
    
    class func getPath(_ fileName: String) -> String {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print("documentDirectory : - \(documentDirectory)")
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        print("Database Path :- \(fileUrl.path)")
        return fileUrl.path
    }
    
    class func copyDatabase(_ filename: String) {
        let dbPath = getPath("VenueData.db")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath) {
            let bundle = Bundle.main.resourceURL
            let file = bundle?.appendingPathComponent(filename)
            var error: NSError?
            do {
                try fileManager.copyItem(atPath: (file?.path)!, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            
            if error == nil {
                print("error in db")
            } else {
                print("Yeah !!")
            }
        }
    }
    
    func getUser(withEmail email: String, password: String) -> UserModel? {
        guard let database = database else {
            print("Database is nil")
            return nil
        }
        
        openDatabase()
        
        let selectQuery = "SELECT * FROM SignUp WHERE email = ?;"
        
        print("retrieve user with email: \(email) and password: \(password)")
        
        do {
            let resultSet = try database.executeQuery(selectQuery, values: [email])
            
            if resultSet.next() {
                let retrievedId = resultSet.long(forColumn: "id")
                let retrievedImageString = resultSet.string(forColumn: "image")
                let retrievedFirstName   = resultSet.string(forColumn: "fname") ?? ""
                let retrievedLastName    = resultSet.string(forColumn: "lname") ?? ""
                let retrievedEmail       = resultSet.string(forColumn: "email") ?? ""
                let retrievedPassword    = resultSet.string(forColumn: "password") ?? ""
                let retrievedMobileNo    = resultSet.string(forColumn: "mobileno") ?? ""
                let retrievedDob         = resultSet.string(forColumn: "dob") ?? ""
                let retrievedCountry     = resultSet.string(forColumn: "country") ?? ""
                let retrievedState       = resultSet.string(forColumn: "state") ?? ""
                let retrievedCity        = resultSet.string(forColumn: "city") ?? ""
                let retrievedAbout       = resultSet.string(forColumn: "aboutme") ?? ""
                let retrievedGender      = resultSet.bool(forColumn: "gender")
                
                if password == retrievedPassword {
                    
                    return UserModel(
                        id: Int(retrievedId),
                        image: retrievedImageString,
                        firstName: retrievedFirstName,
                        lastName: retrievedLastName,
                        email: retrievedEmail,
                        password: retrievedPassword,
                        mobileNo: retrievedMobileNo,
                        dob: retrievedDob,
                        country: retrievedCountry,
                        state: retrievedState,
                        city: retrievedCity,
                        about: retrievedAbout,
                        gender: retrievedGender
                    )
                }
            }
        } catch {
            print("Error retrieving user: \(error.localizedDescription)")
        }
        
        closeDatabase()
        return nil
    }
    
    func read() -> [VenueModel] {
        var arrvenues: [VenueModel] = []

        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return arrvenues
        }

        guard database.open() else {
            print("Unable to open database")
            return arrvenues
        }

        let queryStatementString = "SELECT * FROM venues;"
        do {
            let resultSet = try database.executeQuery(queryStatementString, values: nil)

            while resultSet.next() {
                let name = resultSet.string(forColumn: "name") ?? ""
                let category = resultSet.string(forColumn: "category") ?? ""
                let latitude = resultSet.double(forColumn: "latitude")
                let longitude = resultSet.double(forColumn: "longitude")

                let venue = VenueModel(name: name, category: category, latitude: latitude, longitude: longitude)
                arrvenues.append(venue)

                print("Query Result: Data read frome database")
//                print("\(name) | \(category) | \(latitude) | \(longitude)")
            }
        } catch {
            print("Error executing SELECT query: \(error)")
        }

        database.close()
        return arrvenues
    }
    
    
    func readPostData() -> [PostModel] {
        var arrPost: [PostModel] = []

        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return arrPost
        }

        guard database.open() else {
            print("Unable to open database")
            return arrPost
        }

        let queryStatementString = "SELECT * FROM post;"
        do {
            let resultSet = try database.executeQuery(queryStatementString, values: nil)

            while resultSet.next() {
                let id      = resultSet.long(forColumn: "id")
                let name    = resultSet.string(forColumn: "name") ?? ""
                let title   = resultSet.string(forColumn: "title") ?? ""
                let details = resultSet.string(forColumn: "details")
                let image   = resultSet.string(forColumn: "image")
                let isSelected = resultSet.string(forColumn: "isSelect")
                
                let postData = PostModel(id: id, name: name, title: title, details: details, image: image, isSelcted: isSelected)

                arrPost.append(postData)
                print("Query Result: PostData read frome database\(arrPost.count)")

            }
        } catch {
            print("Error executing SELECT query: \(error)")
        }

        database.close()
        return arrPost
    }

    func setCurrentUser(_ user: UserModel) {
        currentUser = user
    }
    
    func getCurrentUser() -> UserModel? {
        return currentUser
    }
    
    func logOutCurrentUser() {
        currentUser = nil
    }
    
    func getSelectedData() -> [HistoryModel] {
        var arrSelectedData: [HistoryModel] = []
        
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return arrSelectedData
        }
        
        database.open()
        do {
            let query = "SELECT id, image, name, title, date, latitude, longitude FROM History"
            let resultSet = try database.executeQuery(query, values: nil)
    
            while resultSet.next() {
                let historyItem = HistoryModel(
                    id: Int(resultSet.long(forColumn: "id")),
                    image: resultSet.string(forColumn: "image") ?? "",
                    name: resultSet.string(forColumn: "name") ?? "",
                    title: resultSet.string(forColumn: "title") ?? "",
                    date: resultSet.string(forColumn: "date") ?? "",
                    latitude: resultSet.double(forColumn: "latitude"),
                    longitude: resultSet.double(forColumn: "longitude")
                )
                arrSelectedData.append(historyItem)
            }
        } catch {
            print("Error fetching selected data: \(error.localizedDescription)")
        }
        
        database.close()
        return arrSelectedData
    }
    
    func getDeleteData() -> [HistoryModel] {
        var arrDeleteData: [HistoryModel] = []
        
        guard let database = DatabaseManager.shared.database else {
            print("Database not initialized")
            return arrDeleteData
        }
        
        database.open()
        do {
            
            let query = "SELECT id, image, name, title, date, latitude, longitude FROM [Delete]"
            let resultSet = try database.executeQuery(query, values: nil)
            
            while resultSet.next() {
                let historyItem = HistoryModel(
                    id: Int(resultSet.long(forColumn: "id")),
                    image: resultSet.string(forColumn: "image") ?? "",
                    name: resultSet.string(forColumn: "name") ?? "",
                    title: resultSet.string(forColumn: "title") ?? "",
                    date: resultSet.string(forColumn: "date") ?? "",
                    latitude: resultSet.double(forColumn: "latitude"),
                    longitude: resultSet.double(forColumn: "longitude")
                )
                arrDeleteData.append(historyItem)
            }
        } catch {
            print("Error fetching selected data: \(error.localizedDescription)")
        }
        
        database.close()
        return arrDeleteData
    }
    
    func isEmailAlreadyExists(email: String) -> Bool {
        openDatabase()
        
        do {
            let query = "SELECT COUNT(*) FROM SignUp WHERE email = ?;"
            let resultSet = try database.executeQuery(query, values: [email])
            
            if resultSet.next(), let count = resultSet[0] as? Int {
                return count > 0
            }
        } catch {
            print("Error checking email existence: \(error.localizedDescription)")
        }
        
        closeDatabase()
        return false
    }
    
//       search func
//        func search(searchText: String) -> [VenueModel] {
//            guard let database = DatabaseManager.shared.database else {
//                print("Database not initialized")
//                return []
//            }
//
//            guard database.open() else {
//                print("Unable to open database")
//                return []
//            }
//
//            var filteredVenues: [VenueModel] = []
//            let queryStatementString = "SELECT * FROM venues WHERE name LIKE ?;"
//
//            guard let resultSet = try? database.executeQuery(queryStatementString, values: ["%" + searchText + "%"]) else {
//                print("SELECT search statement could not be executed")
//                database.close()
//                return []
//            }
//
//            while resultSet.next() {
//                let name = resultSet.string(forColumn: "name") ?? ""
//                let category = resultSet.string(forColumn: "category") ?? ""
//                let latitude = resultSet.double(forColumn: "latitude")
//                let longitude = resultSet.double(forColumn: "longitude")
//
//                let venue = VenueModel(name: name, category: category, latitude: latitude, longitude: longitude)
//                filteredVenues.append(venue)
//
//                print("Query Result:")
//                print("\(name) | \(category) | \(latitude) | \(longitude)")
//            }
//
//            database.close()
//            return filteredVenues
//        }
}
