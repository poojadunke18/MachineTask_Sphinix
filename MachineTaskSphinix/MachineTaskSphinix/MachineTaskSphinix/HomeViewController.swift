//
//  HomeViewController.swift
//  MachineTaskSphinix
//
//  Created by Mac on 21/03/23.
//

import UIKit
import MapKit
class HomeViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var TableView: UITableView!
   // var locationManager : CLLocationManager!
    var users = [Users]()
    var population = [Populations]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //getCurrentlocation()
        fetchDataUsers()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        fetchData()
        TableView.delegate = self
        TableView.dataSource = self
        let uiNibPopulation = UINib(nibName: "PopulationsTableViewCell", bundle: nil)
        TableView.register(uiNibPopulation, forCellReuseIdentifier: "PopulationsTableViewCell")
        
        let uiNibUser = UINib(nibName: "UsersCollectionViewCell", bundle: nil)
        CollectionView.register(uiNibUser, forCellWithReuseIdentifier: "UsersCollectionViewCell")
    }
    /*func getCurrentlocation(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy =  kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }*/
    func fetchDataUsers(){
        let url = URL(string: "https://gorest.co.in/public/v2/users")
        var urlRequest = URLRequest(url: url!)
       urlRequest.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest){ data,response,error in
            print(data)
            print(response)
            print(error)
            if (error == nil){
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                    for eachData in jsonData{
                        let id = eachData["id"] as! Int
                        let name = eachData["name"] as! String
                        let gender = eachData["gender"] as! String
                        let userObject = Users(id: id, name: name, gender: gender)
                        self.users.append(userObject)
                    }
                    print("Users--",self.users.count)
                    DispatchQueue.main.async {
                        self.CollectionView.reloadData()
                    }
                }
                catch{
                    print("data not found")
                }
            }
    }
        dataTask.resume()
    }
    func fetchData(){
        let url = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population")
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request){
            data, response, error in
            if (error == nil){
                do{
                    let jsonData = try JSONDecoder().decode(Populationsdatamodel.self, from: data!)
                    self.population = jsonData.data
                    print("Population :- ", self.population.count)
                    DispatchQueue.main.async {
                        self.TableView.reloadData()
                    }
                }
                catch{
                    
                }
            }
        }
        dataTask.resume()
    }
}
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.CollectionView.dequeueReusableCell(withReuseIdentifier: "UsersCollectionViewCell", for: indexPath) as! UsersCollectionViewCell
        let data = users[indexPath.row]
        cell.idLabel.text = String(data.id)
        cell.nameLabel.text = data.name
        cell.genderLabel.text = data.gender
        return cell
    }
}
extension  HomeViewController : UITableViewDelegate,UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return population.count
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dataload = population[indexPath.row]
    let cell = TableView.dequeueReusableCell(withIdentifier: "PopulationsTableViewCell", for: indexPath) as! PopulationsTableViewCell
    cell.yearLabel.text = dataload.year
    cell.populationLabel.text = String(dataload.population)
    return cell
}
    }
extension HomeViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue : CLLocationCoordinate2D =  manager.location?.coordinate else{
            return
        }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
}
