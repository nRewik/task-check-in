//
//  VenueDetailViewController.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {

    /* Initialization */
    var venueID: String!
    
    // ------------------------------------------------------------
    // MARK: - States
    
    var venueViewModel: VenueViewModel?{
        didSet{
            
            if let venueViewModel = venueViewModel{
                
                title = venueViewModel.name
                
                if let photoUrl = venueViewModel.photoUrl{
                    fetchVenuePhoto(url: photoUrl)
                }
            }
            
            tableView.reloadData()
        }
    }
    
    // ------------------------------------------------------------
    // MARK: -

    
    let foursquare = Foursquare()
    

    // IBOutlet
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // request complete detail of venue.
        
        let route = VenueRoute.Get(venueID: venueID)
        
        foursquare
            .responseFromRoute(route, accessToken: UserStore.defaultStore.currentUserToken)
            .onSuccess{ json in
                
                let venue = Venue(json: json["response"]["venue"])
                self.venueViewModel = VenueViewModel(venue: venue)
            }
            .onFail{ error in
                print("can't get venue detail: \(error)")
            }
    }
    
    func fetchVenuePhoto(url url: NSURL){
        
        let backgroundQueue = dispatch_queue_create("com.task.check.in.nrewik.io.fetch.photo", nil)
        
        backgroundQueue.async{
            
            guard let imageData = NSData(contentsOfURL: url) else { return }
            
            dispatch_get_main_queue().async{
                self.headerImageView.image = UIImage(data: imageData)
            }
        }
    }
    
}









