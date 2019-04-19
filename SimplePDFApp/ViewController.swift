//
//  ViewController.swift
//  SimplePDFApp
//
//  Created by Ardit Nurcaj. on 4/19/19.
//

import UIKit
import Alamofire

class ViewController: UIViewController, DocumentCellDelegate{
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self

  }
  
  func downloadDocument(cell: DocumentCell) {
    if let index = tableView.indexPath(for: cell){
      print("Pressed download pdf at \(index.row)")
    }
  }
  
  func viewDocument(cell: DocumentCell) {
    if let index = tableView.indexPath(for: cell){
      print("Pressed view pdf at \(index.row)")
    }
  }
  
  @IBAction func viewDocumentPressed(_ sender: Any) {
    if let index = tableView.indexPath(for: (sender as AnyObject).superview??.superview as! UITableViewCell){
      print("Pressed view pdf at \(index.row)")
    }
  }
  
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath) as! DocumentCell
    cell.delegate = self
    cell.titleLabel.text = "\(indexPath.row)"
    cell.selectionStyle = .none
    return cell
  }
  
}
