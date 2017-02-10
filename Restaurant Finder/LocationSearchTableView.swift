//
//  LocationSearchTableView.swift
//  Restaurant Finder
//
//  Created by Garret Koontz on 2/10/17.
//  Copyright © 2017 GK Inc. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableView: UITableViewController {
    
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    var mapSearchDelegate: MapSearch? = nil
    
    func getAddress(selectedItem: MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil)  && (selectedItem.locality != nil || selectedItem.postalCode != nil) ? " " : ""
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@", selectedItem.subThoroughfare ?? "", firstSpace, selectedItem.thoroughfare ?? "", comma, selectedItem.locality ?? "", secondSpace, selectedItem.administrativeArea ?? "")
        
        return addressLine
    }
}

extension LocationSearchTableView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell") else { return UITableViewCell() }
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = getAddress(selectedItem: selectedItem)
        return cell
    }
}

extension LocationSearchTableView {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        mapSearchDelegate?.dropPinAndZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
