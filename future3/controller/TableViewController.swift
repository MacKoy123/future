//
//  TableViewController.swift
//  future3
//
//  Created by Mac on 3/14/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

var myIndex = 0

var filteredTypeBuilding : [Building] = []

class TableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredCabinet = [Cabinet]()
    
    let spinner = UIActivityIndicatorView(style: .gray)
    
    var newType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        tableView.backgroundView = spinner
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        loadJson {
            DispatchQueue.main.async {
                if self.newType != nil {
                    filteredTypeBuilding = buildingState.filter {$0.id == self.newType}
                } else {
                    filteredTypeBuilding = buildingState
                }
                self.spinner.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredTypeBuilding.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredTypeBuilding[section].name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = filteredTypeBuilding[section].id
        var cabinetInBuilding : [Cabinet] = []
        if isFiltering()
        {
            cabinetInBuilding = filteredCabinet.filter{$0.buildingId == key}
        } else {
            cabinetInBuilding = cabinetState.filter{$0.buildingId == key}
        }
        if cabinetInBuilding.isEmpty {
            return 0
        } else {
            return cabinetInBuilding.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cabinet", for: indexPath)
        let key = filteredTypeBuilding[indexPath.section].id
        var cabinetInBuilding : [Cabinet] = []
        if isFiltering() {
            cabinetInBuilding = filteredCabinet.filter{$0.buildingId == key}
        } else {
            cabinetInBuilding = cabinetState.filter{$0.buildingId == key}
        }
        cell.textLabel?.text = cabinetInBuilding[indexPath.row].name
        cell.detailTextLabel?.text = cabinetInBuilding[indexPath.row].id
        cell.detailTextLabel?.isHidden = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as UITableViewCell? else {return}
        myIndex = cabinetState.firstIndex(where: {$0.id == cell.detailTextLabel?.text})!
        performSegue(withIdentifier: "detailSeque", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let key = filteredTypeBuilding[section].id
        var cabinetInBuilding : [Cabinet] = []
        if isFiltering()
        {
            cabinetInBuilding = filteredCabinet.filter{$0.buildingId == key}
        } else {
            cabinetInBuilding = cabinetState.filter{$0.buildingId == key}
        }
        if cabinetInBuilding.isEmpty {
            return 0
        } else {
            return 50
        }
    }
    
    func searchbarisEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCabinet = cabinetState.filter {(cabinet: Cabinet) in
            return cabinet.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchbarisEmpty()
    }
    
    @IBAction func choiceBuildingBarButtonItem(_ sender: UIBarButtonItem) {
        let typeProductAlertController = UIAlertController(title: "Выберите тип товара",
                                                           message: "\n\n\n\n\n\n\n\n",
                                                           preferredStyle: .alert)
        let pickerViewAlert = UIPickerView(frame: CGRect(x: 0, y: 50, width: 260, height: 162))
        pickerViewAlert.dataSource = self
        pickerViewAlert.delegate = self
        typeProductAlertController.view.addSubview(pickerViewAlert)
        let alertActionSelect = UIAlertAction(title: "Выбрать", style: .default) { (_) in
            filteredTypeBuilding = buildingState.filter {$0.id == self.newType}
            self.tableView.reloadData()
        }
        let alertActionClear = UIAlertAction(title: "Сбросить", style: .default) { (_) in
            filteredTypeBuilding = buildingState
            self.newType = nil
            self.tableView.reloadData()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .default)
        typeProductAlertController.addAction(alertActionSelect)
        typeProductAlertController.addAction(alertActionClear)
        typeProductAlertController.addAction(actionCancel)
        present(typeProductAlertController, animated: true, completion: {
            pickerViewAlert.frame.size.width = typeProductAlertController.view.frame.size.width
        })
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let new = searchController.searchBar.text {filterContentForSearchText(new)}
    }
}

extension TableViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return buildingState.count
    }
}

extension TableViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let result = buildingState[row].name
        newType = buildingState[row].id
        return result
    }
}
