//
//  model.swift
//  future3
//
//  Created by Mac on 3/13/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

struct Building {
    var id : String
    var name : String
    init(dictionary : Dictionary<String, Any>) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
    }
}

struct TypeCabinet {
    var id : String
    var name : String
    
    init(dictionary : Dictionary<String, Any>) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
    }
}

struct Cabinet {
    var id : String
    var name : String
    var buildingId : String
    var num : String
    var floor: String
    var typeCabinet: String
    var count : String
    
    init(dictionary : Dictionary<String, Any>) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        buildingId = dictionary["building_id"] as? String ?? ""
        num = dictionary["num"] as? String ?? ""
        floor = dictionary["floor"] as? String ?? ""
        typeCabinet = dictionary["category_id"] as? String ?? ""
        count = dictionary["count"] as? String ?? ""
    }
}
