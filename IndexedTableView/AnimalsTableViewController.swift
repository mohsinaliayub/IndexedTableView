//
//  AnimalsTableViewController.swift
//  IndexedTableView
//
//  Created by Mohsin Ali Ayub on 15.04.22.
//

import UIKit

class AnimalsTableViewController: UITableViewController {

    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // populate data
        tableView.dataSource = dataSource
        updateSnapshot()
    }


}

extension AnimalsTableViewController {
    
    func configureDataSource() -> UITableViewDiffableDataSource<String, String> {
        let dataSource = UITableViewDiffableDataSource<String, String>(tableView: tableView) { tableView, indexPath, animalName in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            // configure the cell
            cell.textLabel?.text = animalName
            
            // Convert the animal name to lower case and
            // then replace all occurences of a space with an underscore
            let imageFileName = animalName.lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFileName)
            
            return cell
        }
        
        return dataSource
    }
    
    func updateSnapshot(animated: Bool = false) {
        // create a snapshot and apply the data
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["all"])
        snapshot.appendItems(animals, toSection: "all")
        
        dataSource.apply(snapshot)
    }
    
}

