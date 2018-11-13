//
//  MasterViewController.swift
//  m_hiking_trails
//
//  Created by Ryan Evans on 11/5/18.
//  Copyright © 2018 Ryan Evans. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var hiking_trails_array = [hiking_trails]()
    

    func populateHikingTrailsArray() {
        //First build URL for end-point
        let endPoint = "http://www.protogic.com/universityservice/service.svc/allhikingtrails"
        let jsURL:URL = URL(string: endPoint)!
        
        //Next, we will esxecute the end point; resulting in getting json
        let jsonUrlData = try? Data(contentsOf: jsURL)
        print(jsonUrlData ?? "Error: No data to print")
        
        //Consume JSON data
        //Take JSON and Serialize it into a Dictionary
        if jsonUrlData != nil {
            let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with: jsonUrlData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print(dictionary)
            let HTD = dictionary["HikingTrails"]! as! [[String:AnyObject]]
            
            for index in 0...HTD.count - 1 {
                let singleTrail = HTD[index]
                let tr = hiking_trails()
                tr.TrailDifficulty = singleTrail["TrailDifficulty"] as! String
                tr.TrailElevation = singleTrail["TrailElevation"] as! String
                tr.TrailName = singleTrail["TrailName"] as! String
                tr.TrailLength = singleTrail["TrailLength"] as! String
                tr.TrailImage = singleTrail["TrailImage"] as! String
                tr.TrailTime = singleTrail["TrailTime"] as! String
                tr.TrailWebsite = singleTrail["TrailWebsite"] as! String
                hiking_trails_array.append(tr)
            }
            
        }
        //Take Dictionary and iterate through values and add to hiking trails array

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateHikingTrailsArray()


        

    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedTrail = hiking_trails_array[indexPath.row] as! hiking_trails
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = selectedTrail
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hiking_trails_array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let selectedTrail = hiking_trails_array[indexPath.row] as! hiking_trails
        cell.textLabel!.text = selectedTrail.TrailName
        
        cell.detailTextLabel!.text = selectedTrail.TrailDifficulty
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}
