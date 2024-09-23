//
//  ViewController.swift
//  ImageViewSwift
//
//  Created by Bhushan Borse
//

import UIKit

@MainActor
class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "earth")
        
        // Option 1: Straight forward approach
         imageView.image = image
        
        // Option 2: Using Dispatchqueue(Traditional Way)
        image?.prepareForDisplay(completionHandler: { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
         })
        
        // Option 3: Using MainActor
        image?.prepareForDisplay(completionHandler: { @MainActor image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        })
        
        // Option 4: Using Swift Concurrency(Modern Way)
        Task {
            imageView.image = await image?.byPreparingForDisplay()
        }
    }
}

