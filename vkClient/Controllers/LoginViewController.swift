import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: - Поля логина и пароля
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // MARK: - Кнопка входа
    @IBOutlet weak var loginButtom: UIButton! {
        didSet {
            loginButtom.layer.cornerRadius = 5
        }
    }
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        // MARK: - Анимация загрузки
        let loadingView = LoadingView(frame: self.view.frame)
        view.addSubview(loadingView)
        
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(scrollTapped))
        scrollView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Наблюдатели открытия и закрытия клавиатуры
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keybordWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keybordWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Открытие и закрытие клавиатуры
    @objc func keybordWillShow(notification: Notification) {
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let kbSize = notification.userInfo?[key] as? CGRect else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        self.view.frame.origin.y = -kbSize.height/2
    }
    @objc func keybordWillHide(notification: Notification) {
        scrollView.contentInset = .zero
        self.view.frame.origin.y = 0
    }
    @objc func scrollTapped(_ sender: UIGestureRecognizer) {
        scrollView.endEditing(true)
    }
    
    // MARK: - Проверка логина и пароля
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // guard identifier == "" else { return true }
        if !isUserLoggedIn() {
            showLoginError()
        }
        return isUserLoggedIn()
    }
    
    private func isUserLoggedIn() -> Bool {
        //return loginTextField.text == "admin" && passwordTextField.text == "123"
        return true
    }
    
    private func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Проверьте данные", preferredStyle: .alert)
        let action = UIAlertAction(title: "Попробовать еще раз", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
