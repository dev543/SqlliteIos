//
//  GlobleFunction.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 24/01/24.
//

import Foundation
import UIKit

class GlobalFunction {

    static let shared: GlobalFunction = GlobalFunction()

    // Alert function
    func showAlert(message: String, from viewController: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { _ in
            print("Ok")
        }
        alert.addAction(alertOk)
        viewController.present(alert, animated: true)
    }
    
    //set image url
    
//    func setImage(fromURL imageUrlString: String?, to imageView: UIImageView) {
//        guard let imageUrl = URL(string: imageUrlString ?? "") else {
//            print("Invalid image URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
//            guard self != nil else { return }
//
//            if let error = error {
//                print("Error loading image: \(error)")
//                return
//            }
//
//            if let imageData = data {
//                DispatchQueue.main.async {
//                    imageView.image = UIImage(data: imageData)
//                }
//            }
//        }.resume()
//    }
}

