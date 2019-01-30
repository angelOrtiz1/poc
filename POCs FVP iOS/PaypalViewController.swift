//
//  paypalViewController.swift
//  POCs FVP iOS
//
//  Created by User on 30/01/19.
//  Copyright © 2019 POCs FVP iOS. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree

class PaypalViewController: UIViewController {
    let utils = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }

    @IBAction func dropInLauncher(_ sender: Any) {
        showDropIn(clientTokenOrTokenizationKey: utils.clientToken)
    }

}
