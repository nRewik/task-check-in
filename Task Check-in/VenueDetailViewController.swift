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
    
    var venue: Venue?{
        didSet{
            guard let venue = venue else { return }
            
            title = venue.name
            
            if let photoUrl = venue.photoUrl{
                fetchVenuePhoto(url: photoUrl)
            }
            
            let titles = ["ID","Name","Description","Tags"]
            let details = [venue.id, venue.name, venue.description, venue.tags.joinWithSeparator(", ")]
            
            itemsToShow = zip(titles, details).map{ (title: $0, detail: $1 ) }
        }
    }
    
    var itemsToShow: [ (title: String, detail: String ) ] = []{
        didSet{
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
                self.venue = Venue(json: json["response"]["venue"])
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









