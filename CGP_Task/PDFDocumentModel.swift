//
//  PDFDocumentModel.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 15.09.2023.
//

import Foundation

struct PDFDocumentModel: Hashable {
    
    let documentURL:URL
    var documentName: String {
        return documentURL.lastPathComponent
    }
    
    var fileAttributes: String? {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: documentURL.path)
            
            var dateText: String?
            if let creationDate = fileAttributes[.creationDate] as? Date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                dateText = dateFormatter.string(from: creationDate)
            }
            
            var fileSizeText: String?
            if let fileSize = fileAttributes[.size] as? NSNumber {
                let fileSizeInKB = fileSize.doubleValue / 1024.0
                fileSizeText = String(format: "%.0f KB", fileSizeInKB)
            }
            
            if let dateText = dateText, let fileSizeText = fileSizeText {
                return "\(dateText) • \(fileSizeText)"
            }
        } catch {
            print("Failed to get file attributes: \(error.localizedDescription)")
        }
        
        return nil
    }
}
