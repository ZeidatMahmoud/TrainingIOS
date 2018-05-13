//
//  DisplayController.swift
//  Token
//
//  Created by mahmoudzeidad on 4/17/18.
//  Copyright © 2018 mahmoudzeidad. All rights reserved.
//

import UIKit
import Alamofire

class DisplayController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    var len = 1
    var array:[[String :Any]] = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let headers = [
            "Authorization": "Bearer " + " " + token
        ]
        Alamofire.request("http://192.168.1.121/androidapp/api/login/list", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                print((response.result.value as Any))  // result of response serialization
                if let JSON = response.result.value as! [[String : Any]]? {
                    print(JSON)
                    self.len = JSON.count
                  self.array = JSON
                    self.tableView?.reloadData()
                }
                
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.len
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
       // cell?.textLabel?.text = self.json[indexPath]
        if self.array.count > 0 {
            let each = self.array[indexPath.row]
            cell?.textLabel?.text = (each["name"] as? String ) ?? ""
            cell?.detailTextLabel?.text = (each["password"] as? String) ?? ""
        }
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
