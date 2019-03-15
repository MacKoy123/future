//
//  JSONmodel.swift
//  future3
//
//  Created by Mac on 3/13/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import Alamofire

var buildingState : [Building] = []

var cabinetTypeState : [TypeCabinet] = []

var cabinetState : [Cabinet] = []

let destinationToDataBuildingState: DownloadRequest.Destination = { _, _ in
    var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    documentsURL.appendPathComponent("dataBuildingState.json")
    return (documentsURL, [.removePreviousFile])
}

let destinationToDataCabinetTypeState: DownloadRequest.Destination = { _, _ in
    var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    documentsURL.appendPathComponent("dataCabinetTypeState.json")
    return (documentsURL, [.removePreviousFile])
}

let destinationToDataCabinetState: DownloadRequest.Destination = { _, _ in
    var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    documentsURL.appendPathComponent("dataCabinetState.json")
    print(documentsURL)
    return (documentsURL, [.removePreviousFile])
}

let urlToDataBuildingState = URL(string: "http://my.guu.ru/json/bit_buildings_data.json")

let urlToDataCabinetTypeState = URL(string: "http://my.guu.ru/json/bit_cabinet_category_data.json")

let urlToDataCabinetState = URL(string: "http://my.guu.ru/json/bit_cabinets_data.json")

func loadJson(completionHandler : (() -> Void)?) {
    guard let jsonURLToDataBuildingState = urlToDataBuildingState else { return }
    AF.download(jsonURLToDataBuildingState, interceptor: nil, to: destinationToDataBuildingState).authenticate(username: "json", password: "KCKPV8zJDx8TX3SZ").responseJSON { response in
        if let array = response.result.value as? [Dictionary<String, Any>] {
            buildingState = array.map{Building(dictionary: $0)}
            completionHandler?()
        }
    }
    
    guard let jsonURLToDataCabinetTypeState = urlToDataCabinetTypeState else { return }
    AF.download(jsonURLToDataCabinetTypeState, interceptor: nil, to: destinationToDataCabinetTypeState).authenticate(username: "json", password: "KCKPV8zJDx8TX3SZ").responseJSON{ response in
        if let array = response.result.value as? [Dictionary<String, Any>] {
            cabinetTypeState = array.map{TypeCabinet(dictionary: $0)}
            completionHandler?()
        }
    }
    
    guard let jsonURLToDataCabinetState = urlToDataCabinetState else { return }
    AF.download(jsonURLToDataCabinetState, interceptor: nil, to: destinationToDataCabinetState).authenticate(username: "json", password: "KCKPV8zJDx8TX3SZ").responseJSON{ response in
        if let array = response.result.value as? [Dictionary<String, Any>] {
            cabinetState = array.map{Cabinet(dictionary: $0)}
            completionHandler?()
        }
    }
}
