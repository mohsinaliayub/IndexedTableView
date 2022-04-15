# IndexedTableView
A table view which displays index on the trailing side of the screen, allowing easy navigation to sections.

# Description
When dealing with a large number of records, it is simple and effective to organize data into sections and provide an index list for easy access.
We populated the data using a **UITableViewDiffableDataSource** and used its sectionIndexTitles(for: UITableView) method to provide sections.

Here is the code that displays section title, index title and index to the section for easy access.
```swift
class AnimalTableDataSource: UITableViewDiffableDataSource<String, String> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        snapshot().sectionIdentifiers[section]
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        snapshot().sectionIdentifiers
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        index
    }
}
```

Just use this custom diffable data source class to create cells and populate data.
```swift
let dataSource = AnimalTableDataSource(tableView: tableView) { tableView, indexPath, animalName in
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    // configure the cell
    cell.textLabel?.text = animalName

    // ...
    return cell
}
tableView.dataSource = dataSource
```

Finally, you will need to create a snapshot, append sections and items to it, and apply the snapshot to the above data source. ```animalsDict``` is
a dictionary of type ```[String: String]``` and ```animalSectionTitles``` is an array of String.
```swift

var snapshot = NSDiffableDataSourceSnapshot<String, String>()
    snapshot.appendSections(animalSectionTitles) // append our sections
    animalSectionTitles.forEach { section in
      if let animals = animalsDict[section] {
          snapshot.appendItems(animals, toSection: section) // for each section, add the items corresponding to that section.
      }
}

dataSource.apply(snapshot)

```

# Screenshots
Here's how the app looks.

<img src="/Screenshots/App.png" width="231" height="500" alt="Indexed Table View">
