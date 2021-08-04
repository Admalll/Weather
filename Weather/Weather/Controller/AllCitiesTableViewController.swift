//
//  AllCitiesTableViewController.swift
//  Weather
//
//  Created by Vlad on 04.08.2021.
//

import UIKit

final class AllCitiesTableViewController: UITableViewController {

    //MARK: Private properties

    var cities = ["Алушта",
                  "Феодосия",
                  "Ялта",
                  "Севастополь",
                  "Симферополь",
                  "Абакан",
                  "Адлер",
                  "Анапа",
                  "Ангарск",
                  "Архангельск",
                  "Астрахань",
                  "Барнаул",
                  "Белгород",
                  "Благовещенск",
                  "Чебоксары",
                  "Челябинск",
                  "Череповец",
                  "Черняховск",
                  "Чита",
                  "Екатеринбург",
                  "Геленджик",
                  "Иркутск",
                  "Ижевск",
                  "Кабардинка",
                  "Калининград",
                  "Казань"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllCitiesTableViewCell") as? AllCitiesTableViewCell else { return UITableViewCell() }
        cell.cityNameLabel.text = cities[indexPath.row]
        return cell
    }
}
