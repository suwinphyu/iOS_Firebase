//
//  DessertsViewController.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/24/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import Firebase


class DessertsViewController: UIViewController {
    static let identifier = "DessertsViewController"
   
    
    @IBOutlet weak var btnFAB: UIButton!
    
    
    var dessertsList : [FoodVO] = []
    var desserts_listener : ListenerRegistration!
    
    @IBOutlet weak var tableViewFoodlList: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.query = baseQuery()
        
        btnFAB.layer.cornerRadius = btnFAB.frame.width/2
        btnFAB.layer.masksToBounds = true
        btnFAB.layer.zPosition = 1
        btnFAB.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        
        
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.desserts_listener = query?.addSnapshotListener({ (querySnapshot, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            let results = querySnapshot?.documents.map({ (document) -> FoodVO in
//                if let dessert = FoodVO(dictionary: document.data(), id: document.documentID){
//                    return dessert
//                }else {
//                    fatalError()
//                }
//            })
//            self.dessertsList = results ?? []
//            self.tableViewFoodlList.reloadData()
//        })
//    }
    
    
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
            
        navigateToAddItem(itemType: "desserts")
    
        
    
        
    }
  
    
    
    func setupTableView(){
        tableViewFoodlList.delegate = self
        tableViewFoodlList.dataSource = self
        tableViewFoodlList.separatorStyle = .none
        tableViewFoodlList.registerForCell(strID: String(describing: FoodItemTableViewCell.self))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    override func viewDidAppear(_ animated: Bool) {
//        self.desserts_listener.remove()
//    }


    
    func baseQuery()-> Query{
        return Firestore.firestore().collection(Sharedconstants.DB_COLLECTION_PATH_DESSERTS)
    }
    var query : Query? {
        didSet{
            if let listener = desserts_listener{
                listener.remove()
            }
        }
    }

}

extension DessertsViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Desserts")
    }
}

extension DessertsViewController: UITableViewDelegate{}

extension DessertsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dessertsList.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodItemTableViewCell.self), for: indexPath) as! FoodItemTableViewCell
         cell.data = dessertsList[indexPath.row]
         return cell
    }
}
