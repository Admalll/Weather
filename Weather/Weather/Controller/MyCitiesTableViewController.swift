//
//  MyCitiesTableViewController.swift
//  Weather
//
//  Created by Vlad on 04.08.2021.
//

import UIKit

class MyCitiesTableViewController: UITableViewController {

    var cities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCitiesTableViewCell") as? MyCitiesTableViewCell else { return UITableViewCell() }
        cell.myCityNameLabel.text = cities[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @IBAction func addCity(seague: UIStoryboardSegue) {
        if seague.identifier == "addCity" {
            guard let vc = seague.source as? AllCitiesTableViewController else { return }
            guard let indexPath = vc.tableView.indexPathForSelectedRow else { return }
            let city = vc.cities[indexPath.row]
            guard !cities.contains(city) else { return }
            cities += [city]
            tableView.reloadData()
        }
    }
}
