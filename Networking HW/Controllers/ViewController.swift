//
//  ViewController.swift
//  Networking HW
//
//  Created by Anfisa Klisho on 25.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var planets = [SWPlanet]()
    
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "error occurred", message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:-Configure table view
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }

    //MARK:-Load data
    private func loadData(){
        let url = URL(string: "https://swapi.dev/api/planets")!
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                //error handling
               print(error)
                self.showAlert(message: error.localizedDescription)
                
                return
                
            }
            
            let response = response as! HTTPURLResponse
            guard let data = data
            else{
                //error handling
                self.showAlert(message: "\(response.statusCode)")
             
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
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanetCell.identifier, for: indexPath) as? PlanetCell
        
        let planet = planets[indexPath.row]
        
        cell?.nameLabel.text = planet.name
        cell?.diameterLabel.text = planet.diameter
        cell?.peopleLabel.text = planet.population
        cell?.climateLabel.text = planet.climate
        
        return cell!
        
    }
    
    
     
    }
    


