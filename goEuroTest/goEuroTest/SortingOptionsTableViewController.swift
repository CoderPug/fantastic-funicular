//
//  SortingOptionsTableViewController.swift
//  goEuroTest
//
//  Created by Santex on 9/28/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

import UIKit

@objc protocol SortingOptionsTableViewControllerDelegate {
    optional func sortingOptionsTableViewControllerDidSelectOption(controller: SortingOptionsTableViewController, selection: SortingCriteriaType)
}

@objc class SortingOptionsTableViewController: UITableViewController {

    var customDelegate: SortingOptionsTableViewControllerDelegate? = nil
    let storeManager = StoreManager.sharedInstance()
    let arrayContent = ["Departure time", "Arrival time", "Duration"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            
            tableView.backgroundColor = UIColor.clearColor()
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            tableView.backgroundView = blurEffectView
            if let popover = navigationController?.popoverPresentationController {
                popover.backgroundColor = UIColor.clearColor()
            }
            tableView.separatorEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let temporalcell = tableView.dequeueReusableCellWithIdentifier("Default") {
            temporalcell.backgroundColor = UIColor.clearColor()
            if let labelText = temporalcell.viewWithTag(1) as? UILabel {
                labelText.text = arrayContent[indexPath.row]
            }
            return temporalcell
        }
        return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "default")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var selectedCriteria: SortingCriteriaType?
        switch indexPath.row {
        case 0:
            selectedCriteria = SortingCriteriaType.Departure
            break
        case 1:
            selectedCriteria = SortingCriteriaType.Arrival
            break
        case 2:
            selectedCriteria = SortingCriteriaType.Duration
            break
        default:
            selectedCriteria = SortingCriteriaType.Departure
            break
        }
        
        if let selectedCriteria = selectedCriteria {
            customDelegate?.sortingOptionsTableViewControllerDidSelectOption?(self, selection: selectedCriteria)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
