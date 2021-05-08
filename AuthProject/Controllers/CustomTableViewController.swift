//
//  CustomTableViewController.swift
//  AuthProject
//
//  Created by Aarón Cervantes Álvarez on 08/05/21.
//

import UIKit
import Alamofire

class CustomTableViewController: UITableViewController {
  
  var dataSource: [[ String: String ]] = []
  var url = "http://janzelaznog.com/DDAM/iOS/gaga/info.json"

  override func viewDidLoad() {
    super.viewDidLoad()
    AF.request(url, method: .get )
      .validate()
      .responseJSON { response in
        guard let arreglo = response.value as? [[ String:String ]] else { return }
        self.dataSource = arreglo
        self.tableView.reloadData()
      }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellTableView", for: indexPath)
    let data = dataSource[indexPath.row]
    cell.textLabel?.text = data["title"] ?? ""
    return cell
  }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  guard let index = tableView.indexPathForSelectedRow else { return }
  let value = dataSource[index.row]
  let viewController = segue.destination as! DetailsViewController
  viewController.photoName = value["pict"] ?? ""
 }
  
}
