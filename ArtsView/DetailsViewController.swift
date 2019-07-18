//
//  DetailsViewController.swift
//  ArtsView
//
//  Created by Jax on 17/07/2019.
//  Copyright © 2019 Jax. All rights reserved.
//

import UIKit
import CoreData



class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var awDescription: UILabel!
    @IBOutlet weak var awImage: UIImageView!
    
    var name = ""
    var desc = ""

    var image = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = name
        awImage.image = image
        
        awDescription.text = desc
       // awDescription.textAlignment = .left

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
   

}
