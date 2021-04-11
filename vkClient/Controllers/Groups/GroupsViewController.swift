import UIKit

class GroupsViewController: UITableViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: Массив групп пользователя
    var groups: [GroupInfo] = [] {
        didSet {
            headerLabel.text = "\(groups.count) групп(ы)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = GroupsFooter.instanceFromNib()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    // MARK: Ячейка с группой
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        cell.configureCell(group: groups[indexPath.row])
        return cell
    }
    
    // MARK: Добавление группы из общего списка
    @IBAction func unwindFromSearch (_ segue: UIStoryboardSegue) {
        guard let controller = segue.source as? GroupSearchViewController, let indexPath = controller.tableView.indexPathForSelectedRow else { return }
        var group = controller.groups[indexPath.row]
        if controller.isSearching {
            group = controller.searchGroup[indexPath.row]
        }
        for i in groups {
            if i == group { return }
        }
        groups.append(group)
        tableView.reloadData()
    }
    
    // MARK: Удаление из списка групп пользователя
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Покинуть"
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
