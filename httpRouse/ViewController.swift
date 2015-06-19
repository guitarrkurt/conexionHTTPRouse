//
//  ViewController.swift
//  httpRouse
//
//  Created by guitarrkurt on 17/06/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDataDelegate {

    let serafia = String()
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    
    //Puede que el server conteste o no
    //Silencia constructor
    var receivedData : NSMutableData?
    
    @IBAction func logIn(sender: AnyObject) {
        let url = NSURL(string: "http://iroseapps.com/moviles/login.php")
        let request =  NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        var bodyData = "username=" + userTextField.text + "&password=" + passwordTextField.text
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        let conn = NSURLConnection(request: request, delegate: self)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        receivedData = NSMutableData(capacity: 0)
        
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        receivedData?.length = 0
    
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        receivedData?.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        NSLog("ERROR: \(error.localizedDescription):\(error.userInfo)")
        
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        let str = NSString(data: receivedData!, encoding: NSASCIIStringEncoding)
        print("viewcontroller: \(str)")
        let alert = UIAlertView()
        
        if(str == "true"){
            performSegueWithIdentifier("secondViewController", sender: self)

        }else{
            alert.title = "ERROR"
            alert.message = str as? String
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

