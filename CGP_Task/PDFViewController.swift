//
//  PDFViewController.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 14.09.2023.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var pdfView: PDFView!
    var pdfURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoScales = true
        self.view.addSubview(pdfView)
        
        if let pdfURL = pdfURL {
            displayPDF(url: pdfURL)
        }
    }
    
    func displayPDF(url: URL) {
        guard let pdfDocument = PDFDocument(url: url) else {
            print("Failed to load the PDF document.")
            return
        }
        pdfView.document = pdfDocument
    }
}
