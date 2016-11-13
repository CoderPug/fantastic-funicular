//
//  SortingOptionsTableViewController.swift
//  goEuroTest
//
//  Created by Santex on 9/28/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

import UIKit

@objc protocol SortingOptionsTableViewControllerDelegate {
    @objc optional func sortingOptionsTableViewControllerDidSelectOption(_ controller: SortingOptionsTableViewController, selection: SortingCriteriaType)
}

@objc class SortingOptionsTableViewController: UITableViewController {

    var customDelegate: SortingOptionsTableViewControllerDelegate? = nil
    let storeManager = StoreManager.sharedInstance()
    let arrayContent = ["Departure time", "Arrival time", "Duration"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            
            tableView.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            tableView.backgroundView = blurEffectView
            if let popover = navigationController?.popoverPresentationController {
                popover.backgroundColor = UIColor.clear
            }
            tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let temporalcell = tableView.dequeueReusableCell(withIdentifier: "Default") {
            temporalcell.backgroundColor = UIColor.clear
            if let labelText = temporalcell.viewWithTag(1) as? UILabel {
                labelText.text = arrayContent[indexPath.row]
            }
            return temporalcell
        }
        return UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "default")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedCriteria: SortingCriteriaType?
        switch indexPath.row {
        case 0:
            selectedCriteria = SortingCriteriaType.departure
            break
        case 1:
            selectedCriteria = SortingCriteriaType.arrival
            break
        case 2:
            selectedCriteria = SortingCriteriaType.duration
            break
        default:
            selectedCriteria = SortingCriteriaType.departure
            break
        }
        
        if let selectedCriteria = selectedCriteria {
            customDelegate?.sortingOptionsTableViewControllerDidSelectOption?(self, selection: selectedCriteria)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
