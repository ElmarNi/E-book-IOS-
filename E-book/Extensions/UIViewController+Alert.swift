//
//  UIViewController+Alert.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 04.07.24.
//

import Foundation
import UIKit

extension UIViewController {
    public func alert(alertTitle: String?, message: String?, actionTitle: String?) {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default))
        present(alertController, animated: true)
    }
}
