//
//  UIViewController+Alert.swift
//  Weather
//
//  Created by Vlad on 03.08.2021.
//
import UIKit
extension UIViewController {
    func showErrorAlert(alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel))
        present(alert, animated: true)
    }
}
