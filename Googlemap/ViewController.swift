//
//  ViewController.swift
//  Googlemap
//
//  Created by appinventiv on 12/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    // variable Declaration
    var latitudeArrayStart = [Any]()
    var longitudeArrayStart = [Any]()
    var latitudeArrayEnd = [Any]()
    var longitudeArrayEnd = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromApi()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            //Register nib
            let cellNib = UINib(nibName: "CustomcellTableViewCell", bundle: nil)
            self.myTableView.register(cellNib, forCellReuseIdentifier: "CustomcellTableViewCell")
            self.myTableView.dataSource = self
            self.myTableView.delegate = self
        })
        
        
    
    
}
    func getDataFromApi() {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "3de07bc1-233c-ba0d-a8e4-ed88098d9f5f"
        ]
        
        let postData = NSMutableData(data: "key=AIzaSyDQ_wmSig8OWrdqPOUMD6YEjsF8rREgUWA".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=Chicago%2CIL&destination=Los%20Angeles%2CCA&waypoints=Joplin%2CMO%7COklahoma%20City%2COK")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                let httpData = String(data:data!, encoding: .utf8)!
                print(httpData)
                // JSON Parsing
                let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
                guard let routes = json as? [String:Any] else{
                    return
                }
                guard let dict = json as? [String:Any] else {
                    return
                }
                // Routes Of Map
                guard let routesData = dict["routes"] as? [[String : AnyObject]]else {return}
                
                guard let legsData = routesData[0]["legs"] as? [[String : AnyObject]] else {return}
                
                guard let startLocation = legsData[0] ["start_location"] as? [String : AnyObject] else {return}
                guard let latitudeOfStartLegs = startLocation["lat"] else {return}
                guard let longitudeOfStartLegs = startLocation["lng"] else {return}
                
                guard let endLocation = legsData[0] ["end_location"] as? [String : AnyObject] else {return}
                
                guard let latitudeOfEndLegs = endLocation["lat"] else {return}
                guard let longitudeOfEndLegs = endLocation["lng"] else {return}
                
                self.latitudeArrayStart.append(latitudeOfStartLegs)
                self.longitudeArrayStart.append(longitudeOfStartLegs)
                self.latitudeArrayEnd.append(latitudeOfEndLegs)
                self.longitudeArrayEnd.append(longitudeOfEndLegs)
                guard let datastep = legsData[0] ["steps"] as? [[String : AnyObject]] else {return}
                for tempIndex in 0..<datastep.count{
                    let start = datastep[tempIndex]["start_location"] as! [String: AnyObject]
                    guard let latitudeOfStart = start["lat"] else {fatalError("not Found")}
                    self.latitudeArrayStart.append(latitudeOfStart)
                    
                    
                    let start1 = datastep[tempIndex]["start_location"] as! [String: AnyObject]
                    guard let longitudeOfStart = start1["lng"]  else {fatalError("not Found")}
                    self.longitudeArrayStart.append(longitudeOfStart)
                    
                    
                    
                    let end = datastep[tempIndex]["end_location"] as! [String: AnyObject]
                    guard let latitudeOfend = end["lat"] else {fatalError("not Found")}
                    self.latitudeArrayEnd.append(latitudeOfend)
                    
                    
                    let end1 = datastep[tempIndex]["end_location"] as! [String: AnyObject]
                    guard let longitudeOfend = end1["lng"] else {fatalError("not Found")}
                    self.longitudeArrayEnd.append(longitudeOfend)
                }
                
               
                print("My latitude Array data of STEPS is \(self.latitudeArrayStart.count)")
                
                print("My Longitude Array data of STEPS is \(self.longitudeArrayStart.count)")
                
                print("My Latitude Array data of of STEPS End is \(self.latitudeArrayEnd.count)")
                
                print("My Longitude Array data end of STEPS is \(self.longitudeArrayEnd.count)")
                
                
                
                
                
                
                
                
            }
        })
        
        dataTask.resume()
        
        
    }
}
// Tableview datasource and delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latitudeArrayStart.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomcellTableViewCell", for: indexPath) as? CustomcellTableViewCell else{
         fatalError("not found")
        }
        cell.startlattitudeLabel.text = String(describing: latitudeArrayStart[indexPath.row])
        cell.startlongitudeLable.text = String(describing: longitudeArrayStart[indexPath.row])
        cell.endLattitudeLabel.text = String(describing: latitudeArrayEnd[indexPath.row])
        cell.endLongitudeLabel.text = String(describing: longitudeArrayEnd[indexPath.row])
        return cell
    }
    
    
}


