//
//  ViewController.swift
//  MapKitWithDataFromDB
//
//  Created by sarkom5 on 15/05/19.
//  Copyright © 2019 sarkom5. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class customPin: NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubtitle: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubtitle
        self.coordinate = location
    }
}

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var listMaps = [ListMaps]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reuqest Alamofire
        setupNewView()
    }
    
//    func request() {
//        if let url = URL(string: "http://10.10.20.40/Restaurant/dataMap.php") {
//            AF.request(url).responseJSON { (response) in
//                let json = JSON(response.value!)
//                let data = json["data"].arrayValue
//
//                for i in data {
//                    let latitudePlace = i["latitude_place"].doubleValue
//                    let longtitudePlace = i["longtitude_place"].doubleValue
//
//                    let latitudeDestination = i["latitude_destination"].doubleValue
//                    let longtitudeDestination = i["longtitude_destination"].doubleValue
//
//                    self.setupView(latitudePlace, longtitudePlace: longtitudePlace, latitudeDestination: latitudeDestination, longtitudeDestination: longtitudeDestination)
//                }
//
//            }
//        }
//    }
    
    
//    func setupView(_ latitudePlace: Double, longtitudePlace: Double, latitudeDestination: Double, longtitudeDestination: Double) {
//
//        let sourceLocation = CLLocationCoordinate2D(latitude: latitudePlace, longitude: longtitudePlace)
//        let destinationLocation = CLLocationCoordinate2D(latitude: latitudeDestination, longitude: longtitudeDestination)
//
//        let sourcePin = customPin(pinTitle: "Kansas City", pinSubtitle: "", location: sourceLocation)
//        let destinationPin = customPin(pinTitle: "St. Louis", pinSubtitle: "", location: destinationLocation)
//        self.mapView.addAnnotation(sourcePin)
//        self.mapView.addAnnotation(destinationPin)
//
//        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
//        let destinationMark = MKPlacemark(coordinate: destinationLocation)
//
//        let directionRequest = MKDirections.Request()
//        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
//        directionRequest.destination = MKMapItem(placemark: destinationMark)
//        directionRequest.transportType = .automobile
//
//        let directions = MKDirections(request: directionRequest)
//        directions.calculate { ( respose, error ) in
//            guard let directionResponse = respose else {
//                if let error = error {
//                    print("we have error getting \(error.localizedDescription)")
//                }
//                return
//            }
//
//            let route = directionResponse.routes[0]
//            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
//
//            let rect = route.polyline.boundingMapRect
//            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
//
//        }
//
//        self.mapView.delegate = self
//    }
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let  renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.strokeColor = .red
//        renderer.lineWidth = 4.0
//
//        return renderer
//    }
    
    func setupNewView() {
        for i in listMaps {
            
            let sourceLocation = CLLocationCoordinate2D(latitude: i.latitudeOfPlace!, longitude: i.longitudeOfPlace!)
            let destinationLocation = CLLocationCoordinate2D(latitude: i.latitudeOfDestination!, longitude: i.longitudeOfDestination!)
            
            let sourcePin = customPin(pinTitle: i.nameOfPlace!, pinSubtitle: "", location: sourceLocation)
            let destinationPin = customPin(pinTitle: i.nameOfDestination!, pinSubtitle: "", location: destinationLocation)
            self.mapView.addAnnotation(sourcePin)
            self.mapView.addAnnotation(destinationPin)
            
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
            let destinationMark = MKPlacemark(coordinate: destinationLocation)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
            directionRequest.destination = MKMapItem(placemark: destinationMark)
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { ( respose, error ) in
                guard let directionResponse = respose else {
                    if let error = error {
                        print("we have error getting \(error.localizedDescription)")
                    }
                    return
                }
                
                let route = directionResponse.routes[0]
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
            
            self.mapView.delegate = self
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let  renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .red
            renderer.lineWidth = 4.0
            
            return renderer
        }

    }
}
