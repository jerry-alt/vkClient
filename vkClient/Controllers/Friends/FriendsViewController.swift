import UIKit

class FriendsViewController: UITableViewController {
    
    // MARK: Структура секций
    struct Section {
        let letter : String
        let users : [UserInfo]
    }
    private var sections = [Section]()

    // MARK: Массив друзей пользователя
    private var friends: [UserInfo] = [
        UserInfo(name: "Алексеева Светлана", age: 29, imageName: "user1.jpeg", city: "Москва"),
        UserInfo(name: "Бодров Илья", age: 36, imageName: "user2.jpeg", city: "Санкт-Петербург"),
        UserInfo(name: "Андреев Ярослав", age: 40, imageName: "user3.jpeg", city: "Астрахань"),
        UserInfo(name: "Тихонов Дмитрий", age: 29, imageName: "user4.jpeg", city: "Саратов"),
        UserInfo(name: "Игнатьева Анастасия", age: 30, imageName: "user5.jpeg", city: "Самара"),
        UserInfo(name: "Сидорова Надежда", age: 28, imageName: "user6.jpeg", city: "Москва"),
        UserInfo(name: "Виноградов Андрей", age: 37, imageName: "user7.jpeg", city: "Казань")
    ]
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        // MARK: Выделяем секции и сортируем пользователей
        let groupedDictionary = Dictionary(grouping: friends, by: {String($0.name.prefix(1))})
        let keys = groupedDictionary.keys.sorted()
        sections = keys.map{ Section(letter: $0, users: groupedDictionary[$0]!) }
        
        let header = FriendsHeader.instanceFromNib(myFriendsNumber: friends.count)
        let footer = FriendsFooter.instanceFromNib()
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
    }
    
    // MARK: Переход к фотографиям пользователя
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controler = segue.destination as? UserPhotoViewController, let indexPath = tableView.indexPathForSelectedRow {
            controler.selectedImageName = sections[indexPath.section].users[indexPath.row].imageName
        }
        return
    }
    
    // MARK: Ячейка с пользователем
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! UserTableViewCell
        let section = sections[indexPath.section]
        cell.configureCell(friend: section.users[indexPath.row])
        return cell
    }
    
    // MARK: Количество ячеек и секций
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].users.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
}
