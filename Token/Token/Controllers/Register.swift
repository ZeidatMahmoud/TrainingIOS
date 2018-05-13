//
//  Register.swift
//  Token
//
//  Created by mahmoudzeidad on 4/16/18.
//  Copyright © 2018 mahmoudzeidad. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class Register: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var Bar: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Bar.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    @IBAction func SignIn(_ sender: Any) {
       Bar.startAnimating()
        
        if(userName.text == "" || password.text == "" ){
            view.makeToast("Please Enter a vaild Username Or Password")
        }
        else if(password.text == confirm.text){
            let params : [String:Any]? = [
                "Name" : userName.text as Any,
                "Password" : password.text as Any
                
            ]
            
            Alamofire.request("http://192.168.1.121/androidapp/api/login/register", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
                .responseString{ response in
                    switch(response.result) {
                       case .success(_):
                        let code  = response.response?.statusCode
                        if(code == 200){
                            
                            self.view.makeToast("Done , Go and Login")
                            self.userName.text = ""
                            self.password.text = ""
                            self.confirm.text = ""
                            self.Bar.stopAnimating()
                        }
                        else{
                            self.view.makeToast("try again")
                        }
                    case .failure(_):
                        self.view.makeToast("try  again")
                        break
                    }
            }
            
        }
        else{
            view.makeToast("Passwords not Matched")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
