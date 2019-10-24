//
//  NavigateToAddItem.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/24/19.
//  Copyright © 2019 swp. All rights reserved.
//


import Foundation
import UIKit

extension UIViewController {
    func navigateToAddItem(itemType : String)  {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: AddItemViewController.identifier) as! AddItemViewController
        viewcontroller.data = itemType
        self.present(viewcontroller, animated: true, completion: nil)
        
        
        
        
    }
}
