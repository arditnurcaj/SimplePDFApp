//
//  ViewController.swift
//  SimplePDFApp
//
//  Created by Ardit Nurcaj. on 4/19/19.
//

import UIKit
import Alamofire
import MBProgressHUD

class ViewController: UIViewController, DocumentCellDelegate {
  
  let urls = [
    "http://gahp.net/wp-content/uploads/2017/09/sample.pdf",
    "http://www.pdf995.com/samples/pdf.pdf",
    "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
    "http://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf",
    "http://ptgmedia.pearsoncmg.com/images/9780134044705/samplepages/9780134044705.pdf"
  ]
  
  var lastPaths = [String]()
  var localFileURLs = [Int: String]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
  }
  
  func downloadDocument(cell: DocumentCell) {
    if let index = tableView.indexPath(for: cell){
      print("Pressed download pdf at \(index.row)")
      self.downloadDocument(index: index.row)
      cell.viewButton.isEnabled = true
    }
  }
  
  func viewDocument(cell: DocumentCell) {
    if let index = tableView.indexPath(for: cell){
      print("Pressed view pdf at \(index.row)")
      performSegue(withIdentifier: "goToPDFReader", sender: cell)
    }
  }
  
  func downloadDocument(index: Int){
    
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.mode = MBProgressHUDMode.annularDeterminate
    hud.label.text = "Loading..."
    
    let url = urls[index]
    
    let destination: DownloadRequest.DownloadFileDestination = {_,_ in
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
      let fileURL = documentsURL.appendingPathComponent(self.lastPaths[index])
      
      return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    Alamofire.download(url, to: destination).downloadProgress(closure: { progress in
      hud.progress = Float(progress.fractionCompleted)
    }).response { response in
      
      hud.hide(animated: true)
      
      if response.error == nil, let filePath = response.destinationURL?.path {
        print(filePath)
        self.localFileURLs[index] = filePath
      }
      
    }
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToPDFReader" {
      let vc = segue.destination as! ReaderViewController
      
      if let sender = sender as? DocumentCell {
        if let index = self.tableView.indexPath(for: sender) {
          vc.url = localFileURLs[index.row]!
        }
      }
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
    if let lastPath = urlsSeparated.last {
      cell.titleLabel.text = lastPath
      lastPaths.append(lastPath)
    }
    cell.selectionStyle = .none
    return cell
  }
  
}
