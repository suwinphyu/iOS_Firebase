//
//  FoodVO.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/24/19.
//  Copyright © 2019 swp. All rights reserved.
//

import Foundation
struct FoodVO {
    var amount : String?
    var foodName : String?
    var imageUrl : String?
    var waitingTime : String?
    var rating : String?
    
    var dictionary : [String : Any]{
        return
            [ "amount" : amount,
              "food_name" : foodName,
              "imageUrl" : imageUrl,
              "rating" : rating,
              "waiting_time" : waitingTime
                
        ]
    }
}

extension FoodVO{
    init?(dictionary : [String : Any], id : String) {
        guard let amount = dictionary["amount"] as? String ,
            let foodName = dictionary["food_name"] as? String,
            let imageUrl = dictionary["imageUrl"] as? String,
            let waitingTime = dictionary["waiting_time"] as? String,
            let rating = dictionary["rating"] as? String
            else {
                return nil
        }
        self.init(amount: amount, foodName: foodName, imageUrl: imageUrl, waitingTime: waitingTime, rating: rating)
    }
    
}
