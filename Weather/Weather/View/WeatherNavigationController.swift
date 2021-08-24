//
//  WeatherNavigationController.swift
//  Weather
//
//  Created by Vlad on 12.08.2021.
//

import UIKit

final class WeatherNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = WeatherPercentDrivenInteractiveTransition()
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController:
                                UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation:
                                UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return WeatherPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return WeatherPopAnimator()
        }
        return nil
    }

}
