//
//  AnimalsTableViewController.swift
//  IndexedTableView
//
//  Created by Mohsin Ali Ayub on 15.04.22.
//

import UIKit

class AnimalsTableViewController: UITableViewController {

    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    var animalsDict = [String: [String]]()
    var animalSectionTitles = [String]()
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate the animals dictionary.
        createAnimalDict()
        
        // populate data
        tableView.dataSource = dataSource
        updateSnapshot()
    }


    private func createAnimalDict() {
        for animal in animals {
            // get the first letter of the animal name and build the dictionary
            let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
            let animalKey = String(animal[..<firstLetterIndex])
            
            // if there are items under the animalKey already, append animal to array
            // otherwise create a new key and value pair with animal as value
            if var animalValues = animalsDict[animalKey] {
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            } else {
                animalsDict[animalKey] = [animal]
            }
        }
        
        // Get the section titles from dictionary's keys and sort them in ascending order
        animalSectionTitles = [String](animalsDict.keys)
        animalSectionTitles.sort { $0 < $1 }
    }
}

extension AnimalsTableViewController {
    
    func configureDataSource() -> UITableViewDiffableDataSource<String, String> {
        let dataSource = AnimalTableDataSource(tableView: tableView) { tableView, indexPath, animalName in
            
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
        // create a snapshot, add items to corresponding sections and apply the data
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(animalSectionTitles)
        animalSectionTitles.forEach { section in
            if let animals = animalsDict[section] {
                snapshot.appendItems(animals, toSection: section)
            }
        }
        
        dataSource.apply(snapshot)
    }
    
}

