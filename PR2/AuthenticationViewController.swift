//
//  AuthenticationViewController.swift
//  PR2
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var fourthField: UITextField!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // We first check that the user is only entering numeric characters
        let numericSet = CharacterSet.decimalDigits
        let stringSet = CharacterSet(charactersIn: string)
        let onlyNumeric = numericSet.isSuperset(of: stringSet)
        
        if !onlyNumeric {
            return false
        }
        
        // We then check that the length of resulting text will be smaller or equal to 1
        let currentString = textField.text as NSString?
        let resultingString = currentString?.replacingCharacters(in: range, with: string)
        
        if let resultingLength = resultingString?.count, resultingLength <= 1 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        doAuthentication()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func doAuthentication() {
        var validCode: Bool
        if let firstCode = firstField.text, let secondCode = secondField.text, let thirdCode = thirdField.text, let fourthCode = fourthField.text {
            let fullCode = firstCode + secondCode + thirdCode + fourthCode
            validCode = Services.validate(code: fullCode)
        } else {
            validCode = false
        }
        
        if validCode {
            performSegue (withIdentifier: "SegueToMainNavigation", sender: self)
        } else {
            let errorMessage = "Sorry, the entered code is not valid"
            let errorTitle = "We could not autenticate you"
            Utils.show (Message: errorMessage, WithTitle: errorTitle, InViewController: self)
        }
    }
    
    // BEGIN-UOC-2
    override func viewDidAppear(_ animated: Bool) {
        firstField.becomeFirstResponder()
    }
    
    @IBAction func firstFieldEditingChanged(_ sender: Any) {
        secondField.becomeFirstResponder()
    }
    
    @IBAction func secondFieldEditingChanged(_ sender: Any) {
        thirdField.becomeFirstResponder()
    }
    
    @IBAction func thirdFieldEditingChanged(_ sender: Any) {
        fourthField.becomeFirstResponder()
    }
    
    @IBAction func fourthFieldEditingChanged(_ sender: Any) {
        doAuthentication()
    }
    // END-UOC-2
}
