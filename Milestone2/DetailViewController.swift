//
//  DetailViewController.swift
//  Milestone2
//
//  Created by Rosalyn Kingsmill on 2017-08-05.
//  Copyright © 2017 Rosalyn Kingsmill. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    var flagName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        

        if let imageToLoad = flagName {
        flagImageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    func shareTapped() {
        let vc = UIActivityViewController(activityItems: [flagImageView.image!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
