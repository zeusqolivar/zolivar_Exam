//
//  Textfield.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/6/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default, handler: nil)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for action in actions {
            alertController.addAction(action)
        }

        self.present(alertController, animated: true, completion: nil)
    }
}


