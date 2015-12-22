//
//  LocaltionTableViewController.swift
//  
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//
//

import UIKit
import CoreLocation

class LocaltionTableViewController: UITableViewController {

    let fousquare = Foursquare()
    let locationManager = CLLocationManager()
    
    /// range that vanue will be searched.
    let discoverRadius = 250 // Km.
    
    
    // ------------------------------------------------------------
    // MARK: - States
    
    var requestingNewVenue = false
    
    var venues: [Venue] = []{
        didSet{
            tableView.reloadData()
        }
    }
    // ------------------------------------------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showVenueDetail"{
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let selectedVenue = venues[indexPath.row]
            
            let venueDetailVC = segue.destinationViewController as! VenueDetailViewController
            venueDetailVC.venueID = selectedVenue.id
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = venues[indexPath.row].name
        
        return cell
    }

}
