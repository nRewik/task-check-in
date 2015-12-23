//
//  VenueDetailViewController+UITableViewDataSource.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 23/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

extension VenueDetailViewController: UITableViewDataSource{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell")!
        
        let item = itemsToShow[indexPath.row]
        cell.textLabel?.text = "\(item.title): \(item.detail)"
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToShow.count
    }
    
}