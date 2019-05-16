//
//  ListOfMapsController.swift
//  MapKitWithDataFromDB
//
//  Created by sarkom5 on 16/05/19.
//  Copyright © 2019 sarkom5. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListMaps: NSObject {
    var nameOfPlace:String?
    var longitudeOfPlace:Double?
    var latitudeOfPlace:Double?
    var nameOfDestination:String?
    var longitudeOfDestination:Double?
    var latitudeOfDestination:Double?
    
    init(namePlace: String, longitudePlace: Double, latitudePlace: Double, nameDestination: String, longitudeDestination: Double, latitudeDestination: Double) {
        self.nameOfPlace = namePlace
        self.longitudeOfPlace = longitudePlace
        self.latitudeOfPlace = latitudePlace
        self.nameOfDestination = nameDestination
        self.longitudeOfDestination = longitudeDestination
        self.latitudeOfPlace  = latitudeDestination
    }
}

class ListOfMapsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listMaps = [ListMaps]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        request()
    }
    
    func request() {
        AF.request("http://10.10.20.40/Restaurant/dataMap.php").responseJSON { (response) in
            let json = JSON(response.value!)
            let data = json["data"].arrayValue
            
            for i in data {
                let namePlace = i["name_place"].stringValue
                let latitudePlace = i["latitude_place"].doubleValue
                let longitudePlace = i["longtitude_place"].doubleValue
                
                let nameDestination = i["name_destination"].stringValue
                let latitudeDestination = i["latitude_destination"].doubleValue
                let longitudeDestination = i["longtitude_destination"].doubleValue
                
                print(namePlace)
                print(nameDestination)
                print(longitudePlace)
                print(latitudePlace)
                print(longitudeDestination)
                print(latitudeDestination)
                
                let model = ListMaps(namePlace: namePlace, longitudePlace: longitudePlace, latitudePlace: latitudePlace, nameDestination: nameDestination, longitudeDestination: longitudeDestination, latitudeDestination: latitudeDestination)
                self.listMaps.append(model)
                self.tableView.reloadData()
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ListOfMapsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! MapCell
        let data = listMaps[indexPath.row]
        
        cell.cityOfPlaceLabel.text = data.nameOfPlace
        cell.cityOfDestinationLabel.text = data.nameOfDestination
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.storyboard.ini
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "detailController") as! ViewController
        controller.listMaps = [listMaps[indexPath.row]]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
