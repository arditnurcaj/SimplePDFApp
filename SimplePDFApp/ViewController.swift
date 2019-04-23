//
//  ViewController.swift
//  SimplePDFApp
//
//  Created by Ardit Nurcaj. on 4/19/19.
//

import UIKit
import Alamofire

class ViewController: UIViewController, DocumentCellDelegate{
  
  let urls = [
    "http://gahp.net/wp-content/uploads/2017/09/sample.pdf",
    "http://www.pdf995.com/samples/pdf.pdf",
    "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
    "http://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf",
    "http://ptgmedia.pearsoncmg.com/images/9780134044705/samplepages/9780134044705.pdf"
  ]
  
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
    return urls.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath) as! DocumentCell
    cell.delegate = self
    
    let urlsSeparated = urls[indexPath.row].components(separatedBy: "/")
    cell.titleLabel.text = urlsSeparated.last
    
    cell.selectionStyle = .none
    return cell
  }
  
}
