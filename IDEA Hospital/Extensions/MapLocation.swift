//
//  lgooleMapLocation.swift
//  IDEA Hospital
//
//  Created by yasser on 12/19/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import MapKit

class LocationOnMap {
    class func openMap(lat: Float, lng: Float, theLocationName: String){
        let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(lng))
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.02))
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: region.span)]
        mapItem.name = theLocationName
        mapItem.openInMaps(launchOptions: options)
    }
}
