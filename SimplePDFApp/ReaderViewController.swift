//
//  ReaderViewController.swift
//  SimplePDFApp
//
//  Created by SITF Pr on 4/23/19.
//

import UIKit
import PDFKit

class ReaderViewController: UIViewController {
  
  @IBOutlet weak var pdfView: PDFView!
  var url: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(url)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    let url = URL(fileURLWithPath: self.url)
    if let pdf = PDFDocument(url: url){
      pdfView.displayMode = .singlePageContinuous
      pdfView.autoScales = true
      // pdfView.displayDirection = .horizontal
      pdfView.document = pdf
    }
  }
  
}
