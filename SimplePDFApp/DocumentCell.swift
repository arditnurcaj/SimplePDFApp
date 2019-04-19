//
//  DocumentCell.swift
//  SimplePDFApp
//
//  Created by SITF Pr on 4/19/19.
//

import UIKit

protocol DocumentCellDelegate {
  func downloadDocument(cell: DocumentCell)
  func viewDocument(cell: DocumentCell)
}

class DocumentCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  var delegate: DocumentCellDelegate?
  
  @IBAction func downloadPressed(_ sender: Any) {
    self.delegate?.downloadDocument(cell: self)
  }
  
  @IBAction func viewDocumentPressed(_ sender: Any) {
    self.delegate?.viewDocument(cell: self)
  }
  
}
