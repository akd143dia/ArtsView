//
//  ArtworksViewController.swift
//  ArtsView
//
//  Created by Jax on 14/07/2019.
//  Copyright © 2019 Jax. All rights reserved.
//

import UIKit

class ArtworksViewController: UITableViewController
{
        var artworks: [Artwork] = []
}

extension ArtworksViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

//        let url = URL(string: "https://www.souljax.com/crossarts/artest2.json")!
        let url = URL(string: "https://www.souljax.com/crossarts/artworks.json")!

        let request = NetworkRequest(url: url)
        request.execute { [weak self] (data) in
            if let data = data
            {
                self?.decode(data)
            }
        }
    }
    
}

extension ArtworksViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtworkCell", for: indexPath) as! ArtworkCell
        let artwork = artworks[indexPath.row]
        
        cell.idLabel.text = String(artwork.id)
        
        cell.titleLabel.text = artwork.title
        cell.titleLabel.textAlignment = .center
        
        
        
        cell.awImage.image = artwork.thumb

        return cell
    }
    
    
  
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var artwork = artworks[indexPath.row]
        if let _ = artwork.thumb {
            return
        }
        let request = NetworkRequest(url: artwork.thumbUrl)
        request.execute { [weak self](data) in
            guard let data = data else {
                return
            }
            artwork.thumb = UIImage(data: data)
            self?.artworks[indexPath.row] = artwork
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("click! : on : \(indexPath.row)")
        
        var name2 = String()
        var img2 = UIImage()
        var desc2 = String()

        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let arw = artworks[indexPath.row]
        
        name2 = (arw.title)
        img2 = (arw.thumb)!
        desc2 = (arw.desc)
    //   name2 = (name.title as? String)!
   //     name2 = (name.value(forKey: "title") as? String)!


        print(name2)
        print(desc2)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
     /*   let secondVC = storyboard.instantiateViewController(withIdentifier: "detailsView") as! DetailsViewController
        secondVC.name = name2
        self.present(secondVC, animated: true, completion: nil)
        */
        
        let vc = storyboard.instantiateViewController(withIdentifier: "detailsView") as! DetailsViewController
        vc.name = name2
        vc.image = img2
        vc.desc = desc2

        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
   
    
    
}

private extension ArtworksViewController {
    func decode(_ data: Data) {
        let decoder = JSONDecoder()
       // decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
        do {
            artworks = try decoder.decode([Artwork].self, from: data)
            tableView.reloadData()
        } catch {
            let title = "Oops, something went wrong"
            let message = "Please make sure you have the latest version of the app."
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: title, style: .default, handler: nil)
            alertController.addAction(dismissAction)
            show(alertController, sender: nil)
        }
    }
}


class ArtworkCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var awImage: UIImageView!
    
}






