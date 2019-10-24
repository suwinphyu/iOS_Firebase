//
//  FoodItemTableViewCell.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/24/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {

    static let identifier = "FoodItemTableViewCell"
    
    @IBOutlet weak var imgViewFood: UIImageView!
    
    @IBOutlet weak var lblFoodName: UILabel!
    
    @IBOutlet weak var lblWaitingTime: UILabel!
    
    @IBOutlet weak var lblAmount: UILabel!
    
    
    var data : FoodVO! {
        didSet{
            
               lblFoodName.text = data.foodName
                lblAmount.text = "$ \(data.amount)"
                lblWaitingTime.text = "Prepare in \(data.waitingTime) min"
                
//                if task.done! {
//                    lblTask.textColor = .green
//                }else{
//                    lblTask.textColor = .blue
//                }
                
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
