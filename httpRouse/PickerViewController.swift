//
//  PickerViewController.swift
//  httpRouse
//
//  Created by guitarrkurt on 18/06/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, NSURLConnectionDataDelegate {

    // MARK - Variables
    @IBOutlet weak var picker: UIPickerView!
    var receivedData : NSMutableData?
    var pickerData = [String]()
    var txtSelected : String = ""
    var primeraVezCarga = true
    // MARK - Actions
    // MARK - Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let url = NSURL(string:"http://iroseapps.com/moviles/opciones.php")
        let datos = NSData(contentsOfURL:url!)
        var cadena = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        
        //cadena = cadena as String
        
        pickerData = (cadena as! String).componentsSeparatedByString("&")
        */
        receivedData = NSMutableData(capacity: 0)
        
        let url = NSURL(string: "http://iroseapps.com/moviles/opciones.php")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        var bodyData = "username=anonymous&password=/123"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        let conn = NSURLConnection(request: request, delegate: self)
        
        //self.picker.dataSource = self
        //self.picker.delegate = self
    }
    
    @IBAction func votar(sender: AnyObject) {
        let url = NSURL(string: "http://iroseapps.com/moviles/votacion.php")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        var bodyData = "voto="+txtSelected
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        let conn = NSURLConnection(request: request, delegate: self)
    }
    
    

    // MARK - Conexion
    
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
        if(primeraVezCarga){
            pickerData = (str as! String).componentsSeparatedByString("&");
            picker.dataSource = self
            picker.delegate = self
            
            primeraVezCarga = false
        }
    }
    
    // MARK - Protocolos
    
    //Numero de componentes que hay en el pickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Numero de elementos que tiene mi variable
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //El titulo que va a tener cada uno de los renglones
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return pickerData[row] as String
    }
    
    //Que hago si ya seleccionaron un renglon
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtSelected = pickerData[row]
        
        println("serafia: \(txtSelected)")
        
        //Si lo selecciona enviamos una alerta
        /*let alert = UIAlertView()
        alert.title = "Usted va a votar por " + pickerData[row] + " es correcto???"
        alert.message = (pickerData[row] as String)
        alert.addButtonWithTitle("Ok")
        alert.show()*/
        
        
    }

    // MARK - Otros metodos
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
