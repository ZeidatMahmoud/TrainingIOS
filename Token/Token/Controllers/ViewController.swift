//
//  ViewController.swift
//  Token
//
//  Created by mahmoudzeidad on 4/16/18.
//  Copyright © 2018 mahmoudzeidad. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import SwiftyJSON

 var token = " "

class ViewController: UIViewController {
   

    @IBOutlet weak var bar: UIActivityIndicatorView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var Password: UITextField!
   
    var list = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bar.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Login(_ sender: Any) {
    bar.startAnimating()
        if(userName.text == "" || Password.text == ""){
            view.makeToast(" Please enter a vaild username or password")
        }
        else{
            let params : [String:Any]? = [
                "Name" : userName.text as Any,
                "Password" : Password.text as Any
                
            ]
            
            Alamofire.request("http://192.168.1.121/androidapp/api/login/login2", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .responseString{ response in
                    
                switch(response.result) {
                    case .success(_):
                        let code = response.response?.statusCode
                        if(code == 200){
                        if let data = response.result.value{
                            let splitted = data.split(separator: ":")[1]
                            let splitted2 = splitted.split(separator: "}")[0] // get the token
                            token = String(splitted2.split(separator: "\"")[0])
                            print(token)
                             let h = "Bearer " + " " + token
                            print(h)
                            }
                            //let secondVeiwcontroller:Register = Register()
                            self.userName.text = ""
                            self.Password.text = ""
                            self.bar.stopAnimating()
                            self.performSegue(withIdentifier: "segue", sender: self)
                          

                            }
                        else if(code == 400){
                            self.view.makeToast("Please Sign In ")
                            self.userName.text = ""
                            self.Password.text = ""
                            self.bar.stopAnimating()
                           
                           
                            }
                        else{
                            self.view.makeToast(" sho sar ???")
                            self.bar.stopAnimating()
                            }
                        
                    
                    
                    case .failure(_):
                      self.view.makeToast("try to login again")
                    break
            }
            }
        }
        
    }
   
    
}

