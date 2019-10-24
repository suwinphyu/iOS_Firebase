//
//  Extensions.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/24/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
import  UIKit

extension UITableView {
    func registerForCell(strID : String){
        register(UINib(nibName: strID, bundle: nil), forCellReuseIdentifier: strID)
    }
    
}
