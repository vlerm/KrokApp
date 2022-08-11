//
//  CitiesViewController.swift
//  KrokApp
//
//  Created by Вадим Лавор on 31.07.22.
//

import UIKit
import Alamofire

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        parseJSON()
    }
    
    func parseJSON() {
        AF.request(Utilities.krokAppGetCitiesUrl).responseJSON { responce in
            switch responce.result {
            case .success:
                if let jsonData = try? JSONDecoder().decode([City].self, from: responce.data!){
                    let filteredOnAlphabet = jsonData.filter({ Utilities.isInAlphabet(name: $0.name!)})
                    let filteredOnEmpty = filteredOnAlphabet.filter({$0.name != String()})
                    print(filteredOnEmpty)
                    self.cities = filteredOnEmpty
                    self.tableView.reloadData()
                } else{
                    print(Utilities.errorParsingData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Utilities.cellIdentifier, for: indexPath) as! CitiesTableViewCell
        cell.cityNameLabel.text = cities[indexPath.row].name
        let url = URL(string: cities[indexPath.row].logo!)!
        do {
            let imageData = try Data(contentsOf: url as URL)
            cell.cityLogoImageView.image = UIImage(data: imageData)
            cell.cityLogoImageView.layer.cornerRadius = 20
        } catch {
            print(Utilities.errorDataLoading)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "AttractionsViewController") as? AttractionsViewController {
            detailViewController.navigationItem.title = cities[indexPath.row].name ?? String()
            detailViewController.id = cities[indexPath.row].id ?? Int()
            self.navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            print(Utilities.errorTransition)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
