//
//  AnimalTableDataSource.swift
//  IndexedTableView
//
//  Created by Mohsin Ali Ayub on 15.04.22.
//

import UIKit

class AnimalTableDataSource: UITableViewDiffableDataSource<String, String> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.snapshot().sectionIdentifiers[section]
    }
    
}
