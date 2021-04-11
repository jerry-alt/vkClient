import UIKit

class GroupSearchViewController: UITableViewController {

    var searchGroup = [GroupInfo]()
    var isSearching = false
    
    // MARK: Полный массив групп 
    var groups: [GroupInfo] = [
        GroupInfo(name: "Рыбки", imageName:"fish.jpg", members: 1455),
        GroupInfo(name: "Лягушки", imageName: "frog.jpg", members: 99),
        GroupInfo(name: "Хомячки", imageName: "hamster.jpg", members: 1347),
        GroupInfo(name: "Лошадки", imageName:"horse.jpg", members: 539),
        GroupInfo(name: "Собачки", imageName:"dog.jpg", members: 4010),
        GroupInfo(name: "Зайчики", imageName:"rabbit.jpg", members: 47),
        GroupInfo(name: "Котики", imageName:"cat.jpg", members: 2039)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchGroup.count
        } else {
            return groups.count
        }
    }
    
    // MARK: Ячейка с группой
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        if isSearching {
            cell.configureCell(group: searchGroup[indexPath.row])
        } else {
            cell.configureCell(group: groups[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension GroupSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchGroup = groups.filter({$0.name.lowercased().contains(searchText) || $0.name.contains(searchText)})
        tableView.reloadData()
        if searchText == "" { searchBarCancelButtonClicked(UISearchBar()) }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
