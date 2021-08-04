//
//  ViewController.swift
//  Weather
//
//  Created by Vlad on 02.08.2021.
//

import UIKit

final class LoginViewController: UIViewController {

    //MARK: - IBOutlets

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var mainScrollView: UIScrollView!

    //MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        disableNotifications()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        return checkLoginInfo()
    }

    //MARK: - Private methods

    private func checkLoginInfo() -> Bool {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return false }
        if login == "admin" && password == "123456" {
            return true
        } else {
            showErrorAlert(alertText: "Ошибка", alertMessage: "Пользователь не найден")
            return false
        }
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func disableNotifications() {
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
                                                    UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupView() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mainScrollView.addGestureRecognizer(hideKeyboardGesture)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary? else { return }
        guard let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size else { return }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)

        mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide(notification: Notification) {
        mainScrollView.contentInset = UIEdgeInsets.zero
    }

    @objc private func hideKeyboard() {
        mainScrollView.endEditing(true)
    }

    //MARK: - IBActions

    @IBAction private func loginButtonTapped(_ sender: UIButton) {

    }
}
