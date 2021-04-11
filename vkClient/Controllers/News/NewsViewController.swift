import UIKit

class NewsViewController: UITableViewController {
    
    @IBOutlet var newsTableView: UITableView!
    
    private var news: [NewsPost] = [
        NewsPost(authorImageName: "user1.jpeg", authorName: "Светлана Алексеева", date: "20.03.2021", text: "🇷🇺 Минцифры опубликовало проект указа президента об электронном паспорте гражданина России. Москвичи смогут оформить его уже в конце года, а жители других регионов — не позднее 1 июля 2023 года.\nПомимо физического электронного документа, его владельцы смогут установить мобильное приложение, которое будет выполнять функции паспорта. Его можно будет использовать, к примеру, при обращении в МФЦ, покупке алкоголя и табака, заключении трудовых договоров.", imageName: "user2.jpeg", likesNumber: 2, commentsNumber: 3, viewsNumber: 4),
        NewsPost(authorImageName: "user3.jpeg", authorName: "Ярослав Андреев", date: "19.03.2021", text: "⚡ У Facebook произошёл глобальный сбой. Не работают все сервисы компании, включая Instagram и WhatsApp.\nСейчас самое время сагитировать своих родственников и знакомых перейти на Telegram.", imageName: nil, likesNumber: 5, commentsNumber: 6, viewsNumber: 7),
        NewsPost(authorImageName: "user4.jpeg", authorName: "Дмитрий Тихонов", date: "18.03.2021", text: "🔍 Государство намерено безвозмездно получить обезличенные сведения о россиянах от операторов персональных данных, говорится в новой версии поправок к закону «О персональных данных».\nБизнес к этой инициативе отнесся скептически, заявив, что это негативно отразится на рынке больших данных и может привести к проблемам с безопасностью.", imageName: "user5.jpeg", likesNumber: 8, commentsNumber: 9, viewsNumber: 10)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.configureCell(news: news[indexPath.row])
        return cell
    }
}
