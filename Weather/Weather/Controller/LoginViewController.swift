//
//  ViewController.swift
//  Weather
//
//  Created by Vlad on 02.08.2021.
//

import UIKit

final class LoginViewController: UIViewController {

    //MARK: - IBOutlets

    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var mainScrollView: UIScrollView!
    @IBOutlet weak var authButton: UIButton!

    private var interactiveAnimator: UIViewPropertyAnimator!

    //MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNotifications()
        animateLoginLabel()
        animateLoginField()
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

    private func setupAnimation() {
        let offset = abs(self.loginLabel.frame.midY -
                            self.passwordLabel.frame.midY)
        self.loginLabel.transform = CGAffineTransform(translationX: 0, y: offset)
        self.passwordLabel.transform = CGAffineTransform(translationX: 0, y:
                                                            -offset)

        UIView.animateKeyframes(withDuration: 1,
                                delay: 1,
                                options: .calculationModeCubicPaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.5,
                                                       animations: {
                                                        self.loginLabel.transform = CGAffineTransform(translationX: 150, y: 50)
                                                        self.passwordLabel.transform = CGAffineTransform(translationX: -150, y:
                                                                                                            -50)
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.5,
                                                       relativeDuration: 0.5,
                                                       animations: {
                                                        self.loginLabel.transform = .identity
                                                        self.passwordLabel.transform = .identity
                                                       })
                                }, completion: nil)
    }

    private func animateLoginField() {
        self.loginLabel.transform = CGAffineTransform(translationX: 0, y:
                                                        -self.view.bounds.height / 2)
        let animator = UIViewPropertyAnimator(duration: 1,
                                              dampingRatio: 0.5,
                                              animations: {
                                                self.loginLabel.transform = .identity
                                              })
        animator.startAnimation(afterDelay: 1)
    }

    private func animateLoginLabel() {

        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        let scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.stiffness = 150
        scaleAnimation.mass = 2
        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = 1
        animationsGroup.beginTime = CACurrentMediaTime() + 1
        animationsGroup.timingFunction = CAMediaTimingFunction(name:
                                                                CAMediaTimingFunctionName.easeOut)
        animationsGroup.fillMode = CAMediaTimingFillMode.backwards
        animationsGroup.animations = [fadeInAnimation, scaleAnimation]
        self.loginLabel.layer.add(animationsGroup, forKey: nil)
        self.passwordLabel.layer.add(animationsGroup, forKey: nil)

    }

    private func animateWrongPassword() {
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: [.autoreverse]) {
            self.passwordTextField.frame.origin.x += 1
            self.passwordTextField.frame.origin.y += 1
        } completion: { (result) in
            self.passwordTextField.layer.borderColor = UIColor.red.cgColor
            self.passwordTextField.layer.borderWidth = 1.0
            self.passwordTextField.frame.origin.x -= 1
            self.passwordTextField.frame.origin.y -= 1
        }

    }

    private func checkLoginInfo() -> Bool {
        guard let login = loginTextField.text, let password = passwordTextField.text else { return false }
        if login == "admin" && password == "123456" {
            return true
        } else {
            //showErrorAlert(alertText: "Ошибка", alertMessage: "Пользователь не найден")
            animateWrongPassword()
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

        let recognizer = UIPanGestureRecognizer(target: self, action:
                                                    #selector(onPan(_:)))
        self.view.addGestureRecognizer(recognizer)
    }

    @objc private func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         dampingRatio: 0.5,
                                                         animations: {
                                                            self.authButton.transform = CGAffineTransform(translationX: 0,
                                                                                                          y: 150)
                                                         })
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = translation.y / 100
        case .ended:
            interactiveAnimator.stopAnimation(true)
            interactiveAnimator.addAnimations {
                self.authButton.transform = .identity
            }
            interactiveAnimator.startAnimation()
        default: return
        }
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
