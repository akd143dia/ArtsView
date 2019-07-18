
//
//  LaunchViewController.swift
//  Launches
//
//  Created by Matteo Manferdini on 04/03/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import UIKit

class ArtworkViewController: UITableViewController {
    
    
    /*
     @IBOutlet var awid: [UILabel]!
     @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
     @IBOutlet weak var awId: UILabel!
     @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var payloadDeploymentTimeLabel: UILabel!
    @IBOutlet weak var payloadsLabel: UILabel!
    @IBOutlet weak var mecoTimeLabel: UILabel!
    @IBOutlet weak var liftoffTimeLabel: UILabel!
    @IBOutlet weak var rocketLabel: UILabel!
    @IBOutlet weak var loadingTimeLabel: UILabel!
     @IBOutlet weak var siteLabel: UILabel!
     @IBOutlet weak var patchActivityIndicator: UIActivityIndicatorView!
     @IBOutlet weak var patchImageView: UIImageView!
     */
    
   
    private var isRefreshing = true
    var artwork: Artwork?
    
}

extension ArtworkViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
        tableView.contentOffset = CGPoint(x:0, y:-refreshControl.frame.size.height)
        tableView.refreshControl?.beginRefreshing()
        fetchArtwork()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isRefreshing ? 0 : super.tableView(tableView, numberOfRowsInSection: 0)
    }
}

private extension ArtworkViewController {
    func fetchArtwork() {
        guard let artwork = artwork else {
            return
        }
        let url = URL(string: "https://www.souljax.com/crossarts/artest2.json")!
            .appendingPathComponent("\(artwork.id)")
        let request = NetworkRequest(url: url)
        request.execute { [weak self] (data) in
            self?.isRefreshing = false
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
            if let data = data {
                self?.decode(data)
            }
        }
    }
    
    func decode(_ data: Data) {
        let decoder = JSONDecoder()
     //   decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
        if let artwork = try? decoder.decode(Artwork.self, from: data) {
            set(artwork)
        }
    }
    
    func set(_ artwork: Artwork) {
     /*   missionNameLabel.text = artwork.missionName
        dateLabel.text = artwork.date.formatted
        statusLabel.text = artwork.succeeded ? "Succeeded" : "Failed"
        siteLabel.text = artwork.site
        rocketLabel.text = artwork.rocket
        payloadsLabel.text = artwork.payloads
        
        let timeline = artwork.timeline
        loadingTimeLabel.text = timeline?.propellerLoading?.formatted
        liftoffTimeLabel.text = timeline?.liftoff?.formatted
        mecoTimeLabel.text = timeline?.mainEngineCutoff?.formatted
        payloadDeploymentTimeLabel.text = timeline?.payloadDeploy?.formatted
        */
        
        
      /*  fetchPatch(withURL: artwork.thumbUrl)*/
    }
    
 /*   func fetchPatch(withURL url: URL) {
        let request = NetworkRequest(url: url)
        request.execute { [weak self] (data) in
            guard let data = data else {
                return
            }
            //////self?.artworkThumb.image = UIImage(data: data)
           // self?.patchActivityIndicator.stopAnimating()
        }
    }*/
}


extension Int {
    var formatted: String {
        let sign = self >= 0 ? "+" : ""
        return "T" + sign + "\(self)"
    }
}

extension Bool {
    var formatted: String {
        return self ? "Succeeded" : "Failed"
    }
}

class ArtworkDetCell: UITableViewCell {
    
    
     @IBOutlet weak var img: UIImageView!
    
    
    
}

