//
//  DrinksViewController.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/24/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import Firebase

class DrinksViewController: UIViewController {

    var drinksList : [FoodVO] = []
    var drinks_listener : ListenerRegistration!
    
    @IBOutlet weak var tableViewDrinksList: UITableView!
     @IBOutlet weak var btnFAB: UIButton!
    
    static let identifier = "DrinksViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDrinksList.delegate = self
        tableViewDrinksList.dataSource = self
        tableViewDrinksList.registerForCell(strID: String(describing: FoodItemTableViewCell.self))
        tableViewDrinksList.separatorStyle = .none

      
        self.query = baseQuery()
        
        btnFAB.layer.cornerRadius = btnFAB.frame.width/2
        btnFAB.layer.masksToBounds = true
        btnFAB.layer.zPosition = 1
        btnFAB.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func onClickbtnFAB(_ sender: Any) {
        UIView.animate(withDuration: 0.3)
        {
            if self.btnFAB.transform == .identity{
                self.btnFAB.transform = CGAffineTransform(rotationAngle: 45 * .pi / 180)
                self.btnFAB.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else{
                self.btnFAB.transform = .identity
                self.btnFAB.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
        }
        
        navigateToAddItem(itemType: "drinks")
    
        
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.drinks_listener = query?.addSnapshotListener({ (querySnapshot, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            let results = querySnapshot?.documents.map({ (document) -> FoodVO in
//                if let drink = FoodVO(dictionary: document.data(), id: document.documentID){
//                    return drink
//                }else {
//                    fatalError()
//                }
//            })
//            self.drinksList = results ?? []
//            self.tableViewDrinksList.reloadData()
//        })
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        self.drinks_listener.remove()
//    }
//    
//    
    
    func baseQuery()-> Query{
        return Firestore.firestore().collection(Sharedconstants.DB_COLLECTION_PATH_DRINKS)
    }
    var query : Query? {
        didSet{
            if let listener = drinks_listener{
                listener.remove()
            }
        }
    }
}

extension DrinksViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Drinks")
    }
}

extension DrinksViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksList.count
       // return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodItemTableViewCell.self), for: indexPath) as! FoodItemTableViewCell
        cell.data = drinksList[indexPath.row]
        return cell
    }
}

extension DrinksViewController : UITableViewDelegate{}
