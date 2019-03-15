//
//  DetailViewController.swift
//  future3
//
//  Created by Mac on 3/14/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameBuildingLabel: UILabel!
    
    @IBOutlet weak var floorLabel: UILabel!
    
    @IBOutlet weak var typeCabinetLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = cabinetState[myIndex].name
        nameBuildingLabel.text = buildingState.filter{$0.id == cabinetState[myIndex].buildingId}[0].name
        floorLabel.text = cabinetState[myIndex].floor
        typeCabinetLabel.text = cabinetTypeState.filter{$0.id == cabinetState[myIndex].typeCabinet}[0].name
        countLabel.text = cabinetState[myIndex].count
    }
    
}
