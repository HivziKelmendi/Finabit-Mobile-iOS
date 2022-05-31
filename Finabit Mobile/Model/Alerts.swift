//
//  Alerts.swift
//  Finabit Mobile
//
//  Created by Hivzi on 15.3.22.
//

import Foundation
import UIKit

struct Alerts {
    
        func showfailureAlert(view: UIViewController) {
            DispatchQueue.main.async {

                let alert = UIAlertController(title: "Verejtje", message: "Pini gabim", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                view.parent!.present(alert, animated: true) }
      }
    }

