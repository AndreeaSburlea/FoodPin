//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 4/14/22.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    // swiftlint:disable line_length
    enum Section {
        case all
    }

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    var restaurantIsFavorites = Array(repeating: false, count: 21)

    lazy var dataSource = configureDataSource()

    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "favoritecell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, restaurantNames in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell
                else {
                    return UITableViewCell()
                }
                cell.configureCell(name: self.restaurantNames[indexPath.row],
                                   location: self.restaurantLocations[indexPath.row],
                                   type: self.restaurantTypes[indexPath.row],
                                   image: self.restaurantImages[indexPath.row],
                                   heartImageValue: self.restaurantIsFavorites[indexPath.row])
                return cell
            }
        )
        return dataSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Creating an option menu
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)

        // Popover menu
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }

        // "Mark/Remove as favorite" action
        let favoriteAction = UIAlertAction(title: "Mark as favorite", style: .default, handler: {(_:UIAlertAction!) -> Void in
            self.restaurantIsFavorites[indexPath.row] = true
            self.tableView.reloadData()
        })

        let removeAction = UIAlertAction(title: "Remove from favorites", style: .default, handler: {(_:UIAlertAction!) -> Void in
            self.restaurantIsFavorites[indexPath.row] = false
            self.tableView.reloadData()
        })

        if restaurantIsFavorites[indexPath.row] == true {
            optionMenu.addAction(removeAction)
        } else {
            optionMenu.addAction(favoriteAction)
        }

        // "Reserve a table" action
        let reserveActionHandler = {(_:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }

        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        optionMenu.addAction(reserveAction)

        // Display the menu
        present(optionMenu, animated: true, completion: nil)

        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
