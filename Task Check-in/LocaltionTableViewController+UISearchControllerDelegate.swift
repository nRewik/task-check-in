//
//  LocaltionTableViewController+UISearchControllerDelegate.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 23/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

extension LocaltionTableViewController: UISearchControllerDelegate{
    
    func willPresentSearchController(searchController: UISearchController) {
        searchVenues.removeAll() // clear last search venues
        searching = true
    }
    
    func willDismissSearchController(searchController: UISearchController) {
        searching = false
    }
    
}