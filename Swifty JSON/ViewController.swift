//
//  ViewController.swift
//  Swifty JSON
//
//  Created by Zac Wolff on 9/11/15.
//  Copyright (c) 2015 GH4HUB Ghana Limited. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate
{

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var pin: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var signin: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.pin.delegate = self
        self.phone.delegate = self
        
        indicator.hidden = true
        //signin.enabled = false
        indicator.hidesWhenStopped = true
        
        let phoneLeftPaddingView = UIView(frame: CGRectMake(0, 0, 10, self.phone.frame.height))
        phone.leftView = phoneLeftPaddingView
        phone.leftViewMode = UITextFieldViewMode.Always

        let pinLeftPaddingView = UIView(frame: CGRectMake(0, 0, 10, self.pin.frame.height))
        pin.leftView = pinLeftPaddingView
        pin.leftViewMode = UITextFieldViewMode.Always

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signInButton(sender: AnyObject)
    {
        indicator.hidden = false
        indicator.startAnimating()

        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue())
        {
            
            let phoneText = self.phone.text
            let pinText = self.pin.text
            /*
            Alamofire.request(.GET, "http://10.43.33.51:8000/api/v1/agent/\(pinText)/\(phoneText)").responseJSON()
            {
                (_, _, data, _) in
                
                if data == nil
                {
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Incorrect Pin"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("Okay")
                    alertView.show()
                    
                    self.indicator.stopAnimating()
                }
                else
                {
                    
                }

                println(data)
            }
            */
            
            Alamofire.request(.GET, "https://jat-testing.herokuapp.com/api/v1/agent/\(pinText)/\(phoneText)").responseJSON()
                {
                    (_, _, data, _) in
                    
                    if data == nil
                    {
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Incorrect Pin"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("Okay")
                        alertView.show()
                        
                        self.indicator.stopAnimating()
                    }
                    else
                    {
                        
                    }
                    
                    println(data)
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        /*
        if (pin.text == "") || (phone.text == "")
        {
            signin.enabled = false
        }
        else
        {
            signin.enabled = true
        }
        */
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        view.endEditing(true)
    }
}