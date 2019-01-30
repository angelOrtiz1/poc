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

class PaypalViewController: UIViewController, BTAppSwitchDelegate {
    @IBOutlet var buttonPayment: UIButton!
    var braintreeClient: BTAPIClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            buttonPayment.setTitle("Mi boton", for: .normal)
        self.braintreeClient = BTAPIClient( authorization: "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIyYWM2MjQ3ZTQzOGM4ZTYzZTdiY2JkM2JjZDdlN2ZhYTAwNjZlZjE4OTEzZWJhNGRjNmQ0ZTE1MTJmOTI2NWY2fGNsaWVudF9pZD1jbGllbnRfaWQkc2FuZGJveCQ0ZHByYmZjNnBoNTk1Y2NqXHUwMDI2Y3JlYXRlZF9hdD0yMDE5LTAxLTMwVDIyOjA4OjM0LjU5ODUzMjA3MCswMDAwXHUwMDI2bWVyY2hhbnRfaWQ9Mnlia2tmdDlrNXdyd3FrNCIsImNvbmZpZ1VybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy8yeWJra2Z0OWs1d3J3cWs0L2NsaWVudF9hcGkvdjEvY29uZmlndXJhdGlvbiIsImdyYXBoUUwiOnsidXJsIjoiaHR0cHM6Ly9wYXltZW50cy5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tL2dyYXBocWwiLCJkYXRlIjoiMjAxOC0wNS0wOCJ9LCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzJ5YmtrZnQ5azV3cndxazQvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vb3JpZ2luLWFuYWx5dGljcy1zYW5kLnNhbmRib3guYnJhaW50cmVlLWFwaS5jb20vMnlia2tmdDlrNXdyd3FrNCJ9LCJ0aHJlZURTZWN1cmVFbmFibGVkIjpmYWxzZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiT1RBIERpcmVjdHJpcHMncyBUZXN0IFN0b3JlIiwiY2xpZW50SWQiOiJBWTFOZF85N1ZvT3BiX002cmUzREpDdW1la19KNDM4UzI5dTl5Z1pMWWMxZEJmcGkwdjA2R3RJTE1FX0ZsU29oUVRNWUZ6RURCQnE2MmdhUSIsInByaXZhY3lVcmwiOiJodHRwczovL2V4YW1wbGUuY29tIiwidXNlckFncmVlbWVudFVybCI6Imh0dHBzOi8vZXhhbXBsZS5jb20iLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjpmYWxzZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImJyYWludHJlZUNsaWVudElkIjoibWFzdGVyY2xpZW50MyIsImJpbGxpbmdBZ3JlZW1lbnRzRW5hYmxlZCI6dHJ1ZSwibWVyY2hhbnRBY2NvdW50SWQiOiJNWE4iLCJjdXJyZW5jeUlzb0NvZGUiOiJNWE4ifSwibWVyY2hhbnRJZCI6IjJ5YmtrZnQ5azV3cndxazQiLCJ2ZW5tbyI6Im9mZiJ9" )
        
        buttonPayment.addTarget(self, action: #selector(self.customPayment), for: UIControl.Event.touchUpInside)
    }
    
    @objc func customPayment() {
        let payPalDriver = BTPayPalDriver(apiClient: self.braintreeClient)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self
        
        // Start the Vault flow, or...
        payPalDriver.authorizeAccount() { (tokenizedPayPalAccount, error) -> Void in
            print(tokenizedPayPalAccount)
        }
        
        // ...start the Checkout flow
        let payPalRequest = BTPayPalRequest(amount: "1.00")
        payPalDriver.requestOneTimePayment(payPalRequest) { (tokenizedPayPalAccount, error) -> Void in
            print(tokenizedPayPalAccount)
        }
    }
    

}
