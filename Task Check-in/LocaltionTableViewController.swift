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
    let searchController = UISearchController(searchResultsController: nil)
    
    /// range that vanue will be searched.
    let discoverRadius = 750.0 // Metres
    
    
    // ------------------------------------------------------------
    // MARK: - States
        
    var searching = false{
        didSet{
            tableView.reloadData()
        }
    }
    
    var nearbyVenues: [Venue] = []
    var searchVenues: [Venue] = []
    // ------------------------------------------------------------

    
    
    
    // ------------------------------------------------------------
    // MARK: - Computed Properties
    
    var venuesToShow: [Venue]{
        return searching ? searchVenues : nearbyVenues
    }
    
    // ------------------------------------------------------------

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        definesPresentationContext = true
        
        setupSearchController()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showVenueDetail"{
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let selectedVenue = venuesToShow[indexPath.row]
            
            let venueDetailVC = segue.destinationViewController as! VenueDetailViewController
            venueDetailVC.venueID = selectedVenue.id
        }
    }
    
    func setupSearchController(){
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuesToShow.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = venuesToShow[indexPath.row].name
        
        return cell
    }
    
}
