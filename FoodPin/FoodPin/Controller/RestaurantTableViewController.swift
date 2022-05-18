//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 4/14/22.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController {
    // swiftlint:disable line_length
    @IBOutlet private var emptyRestaurantView: UIView!

    @IBAction private func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    var restaurants: [Restaurant] = []
    var fetchResultController: NSFetchedResultsController<Restaurant>!
    var searchController: UISearchController!
    lazy var dataSource = configureDataSource()

    // MARK: - UITableView Diffable Data Source
    func configureDataSource() -> RestaurantDiffableDataSource {
        let cellIdentifier = "datacell"
        let dataSource = RestaurantDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, _ in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantTableViewCell

                cell?.configureCell(name: self.restaurants[indexPath.row].name,
                                    location: self.restaurants[indexPath.row].location,
                                    type: self.restaurants[indexPath.row].type,
                                    image: UIImage(data: self.restaurants[indexPath.row].image)!,
                                    favoriteImageValue: self.restaurants[indexPath.row].isFavorite
                )
                return cell
            }
        )
        return dataSource
    }

    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRestaurantData()

        tableView.dataSource = dataSource
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: false)

        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true

        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle") as Any]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle") as Any, .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.backButtonTitle = ""

        // Prepare the empty view
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true

        // Search bar
        searchController = UISearchController(searchResultsController: nil)
        // Search bar in the navigation bar
        self.navigationItem.searchController = searchController

        // Search bar in the table header view
//        tableView.tableHeaderView = searchController.searchBar

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        searchController.searchBar.placeholder = String(localized: "Search restaurants...")
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(named: "NavigationBarTitle")

        navigationItem.largeTitleDisplayMode = .always
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.hidesBarsOnSwipe = true
    }

    override func viewDidAppear(_ animated: Bool) {

        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }

        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as? RestaurantDetailViewController
                destinationController?.restaurant = self.restaurants[indexPath.row]
            }
        }
    }

    func fetchRestaurantData(searchText: String = "") {
        // Fetch data from data source
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()

        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR location CONTAINS[c] %@", argumentArray: [searchText, searchText])
        }

        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self

            do {
                try fetchResultController.performFetch()
                updateSnapshot(animatingChange: searchText.isEmpty ? false : true)
            } catch {
                print(error)
            }
        }
    }

    func updateSnapshot(animatingChange: Bool = false) {
        if let fetchedObjects = fetchResultController.fetchedObjects {
            restaurants = fetchedObjects
        }
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: animatingChange)

        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true
    }

    // MARK: - UITableViewDelegate Protocol
    // Swipe left action
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Disable delete and share buttons
        if searchController.isActive {
            return UISwipeActionsConfiguration()
        }

        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }

        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in

            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext

                // Delete the item
                context.delete(restaurant)
                appDelegate.saveContext()

                // Update the view
                self.updateSnapshot(animatingChange: true)
            }

            // Call completion handler to dismis the action button
            completionHandler(true)
        }

        // Share action
        let shareAction = UIContextualAction(style: .normal, title: "Share") {(_, _, completionHandler) in
            let defaultText = "Just checking in at" + restaurant.name
            let activityController: UIActivityViewController

            if let imageToShare = UIImage(data: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }

            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }

            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }

        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")

        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")

        // Configure both actions as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }

    // Swipe right action
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Get the selected restaurant
        guard self.dataSource.itemIdentifier(for: indexPath) != nil else {
            return UISwipeActionsConfiguration()
        }

        // Favorite action
        let favoriteAction = UIContextualAction(style: .normal, title: "") { (_, _, completionHandler) in
            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
            tableView.reloadData()
            completionHandler(true)
        }

        let favoriteActionImage = self.restaurants[indexPath.row].isFavorite ? UIImage(systemName: "heart.slash.fill") : UIImage(systemName: "heart.fill")
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = favoriteActionImage

        // Configure favorite actions
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return swipeConfiguration
    }
}
    // swiftlint:disable force_cast
    extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3

        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
                cell.configureDescriptionCell(text: restaurant.summary)
                return cell

            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTwoColumnCell.self), for: indexPath) as! RestaurantDetailTwoColumnCell

                cell.configureAdressTitleLabel(text: "Adress")
                cell.configureAdressTextLabel(text: restaurant.location)
                cell.configurePhoneTitleLabel(text: "Phone")
                cell.configurePhoneTextLabel(text: restaurant.phone)
                return cell

            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
                cell.configure(location: restaurant.location)
                cell.selectionStyle = .none
                return cell

            default:
                fatalError("Failed to instatiate the table view cell for detail view controller")
        }
    }
}

    extension RestaurantTableViewController: NSFetchedResultsControllerDelegate {
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            updateSnapshot()
    }
}

extension RestaurantTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }

        fetchRestaurantData(searchText: searchText)
    }
}
