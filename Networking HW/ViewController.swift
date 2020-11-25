//
//  ViewController.swift
//  Networking HW
//
//  Created by Anfisa Klisho on 25.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var planets = [SWPlanet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK:-Load data
    private func loadData(){
        let url = URL(string: "https://swapi.dev/api/planets/")!
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
               print(error)
                //alert
                //error.localizedDescription
                return
                
            }
            
            let response = response as! HTTPURLResponse
            guard let data = data as? Data
            else{
                //error
                //response.statusCode
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any?]
                
                let jsonArray = json!["results"] as! [ [String: Any?] ]
                
                for object in jsonArray{
                    if let name = object["name"] as? String,
                       let population = object["population"] as? String,
                       let diameter = object["diameter"] as? String,
                       let climate = object["climate"] as? String{
                        
                        self.planets.append(SWPlanet(name: name, population: population, diameter: diameter, climate: climate))
                    }
                }
            }
            catch (let jsonError){
                print(jsonError)
            }
            
            
        }
        
        task.resume()
    }
}
    
    //MARK:-Table view data source

    


