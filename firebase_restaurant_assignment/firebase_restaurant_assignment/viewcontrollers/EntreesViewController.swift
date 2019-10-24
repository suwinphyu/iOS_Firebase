//
//  EntreesViewController.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/24/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import Firebase

class EntreesViewController: UIViewController {

    var entreesList : [FoodVO] = []
    var listener : ListenerRegistration!
    
    @IBOutlet weak var btnFAB: UIButton!
    @IBOutlet weak var tableviewEntreesList: UITableView!
    
    static let identifier = "EntreesViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewEntreesList.delegate = self
        tableviewEntreesList.dataSource = self
        tableviewEntreesList.separatorStyle = .none
        tableviewEntreesList.registerForCell(strID: String(describing: FoodItemTableViewCell.self))

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
        
        navigateToAddItem(itemType: "entrees")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listener = query?.addSnapshotListener({ (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let results = querySnapshot?.documents.map({ (document) -> FoodVO in
                if let entree = FoodVO(dictionary: document.data(), id: document.documentID){
                    return entree
                }else {
                    fatalError()
                }
            })
            self.entreesList = results ?? []
            self.tableviewEntreesList.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.listener.remove()
    }
    
    
    
    func baseQuery()-> Query{
        return Firestore.firestore().collection(Sharedconstants.DB_COLLECTION_PATH_DRINKS)
    }
    var query : Query? {
        didSet{
            if let listener = listener{
                listener.remove()
            }
        }
    }
    
}

extension EntreesViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Entrees")
    }
}

extension EntreesViewController: UITableViewDelegate {}

extension EntreesViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entreesList.count
      //  return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodItemTableViewCell.self), for: indexPath) as! FoodItemTableViewCell
        cell.data = entreesList[indexPath.row]
        return cell
    }
}
