//
//  DetailViewController.swift
//  m_hiking_trails
//
//  Created by Ryan Evans on 11/5/18.
//  Copyright © 2018 Ryan Evans. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.TrailName
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: hiking_trails? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

