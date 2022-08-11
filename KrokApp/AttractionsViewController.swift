//
//  AttractionsViewController.swift
//  KrokApp
//
//  Created by Вадим Лавор on 1.08.22.
//

import UIKit
import Alamofire

class AttractionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var attractions = [Attraction]()
    var id = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        parseJSON()
    }
    
    func parseJSON() {
        AF.request(Utilities.krokAppGetPointsUrl).responseJSON { responce in
            switch responce.result {
            case .success:
                if let jsonData = try? JSONDecoder().decode([Attraction].self, from: responce.data!){
                    let filteredOnAlphabet = jsonData.filter({ Utilities.isInAlphabet(name: $0.name!)})
                    let filteredOnEmpty = filteredOnAlphabet.filter({$0.name != String()})
                    let filtered = filteredOnEmpty.filter { $0.city_id == self.id }
                    self.attractions = filtered
                    print(self.attractions)
                    self.tableView.reloadData()
                } else {
                    print(Utilities.errorParsingData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension AttractionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Utilities.cellIdentifier, for: indexPath) as! AttractionsTableViewCell
        cell.attractionNameLabel.text = attractions[indexPath.row].name
        let url = URL(string: attractions[indexPath.row].logo!)!
        do {
            let imageData = try Data(contentsOf: url as URL)
            cell.attractionLogoImageView.image = UIImage(data: imageData)
            cell.attractionLogoImageView.layer.cornerRadius = 20
        } catch {
            print(Utilities.errorDataLoading)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailAttractionViewController") as? DetailAttractionViewController {
            detailViewController.attractionName = attractions[indexPath.row].name ?? String()
            detailViewController.attractionDescription = attractions[indexPath.row].text!.htmlStripped
            detailViewController.dateOfPublication = "Date of publication: " + (attractions[indexPath.row].creation_date ?? String())
            detailViewController.imagesStringUrl = attractions[indexPath.row].images ?? [String]()
            detailViewController.soundUrl = attractions[indexPath.row].sound ?? String()
            self.navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            print(Utilities.errorTransition)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


