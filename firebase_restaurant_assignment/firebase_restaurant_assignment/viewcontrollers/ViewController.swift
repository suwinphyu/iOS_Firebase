//
//  ViewController.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/23/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ViewController: ButtonBarPagerTabStripViewController {

   // let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    let purpleInspireColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0)
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
           
        }
        
        super.viewDidLoad()
      
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let entrees = UIStoryboard(name: Sharedconstants.storyboards.SB_MAIN, bundle: nil).instantiateViewController(withIdentifier: EntreesViewController.identifier)
        let mains = UIStoryboard(name: Sharedconstants.storyboards.SB_MAIN, bundle: nil).instantiateViewController(withIdentifier: MainsViewController.identifier)
        let drinks = UIStoryboard(name: Sharedconstants.storyboards.SB_MAIN, bundle: nil).instantiateViewController(withIdentifier: DrinksViewController.identifier)
        let desserts = UIStoryboard(name: Sharedconstants.storyboards.SB_MAIN, bundle: nil).instantiateViewController(withIdentifier: DessertsViewController.identifier)
        return[entrees,mains,drinks,desserts]
    
        
    }
}

