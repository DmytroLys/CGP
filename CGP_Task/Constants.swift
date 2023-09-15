//
//  Constants.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 15.09.2023.
//

struct Constants {
    
    // MARK: - Generic Constants
    static let searchBarPlaceholder = "Search documents"
    static let navBarTitle = "My Files"
    
    // MARK: - Image Names
    struct ImageNames {
        static let bell = "bell"
        static let ellipsis = "ellipsis"
        static let ellipsisRectangleFill = "ellipsis.rectangle.fill"
    }
    
    // MARK: - Colors
    struct Colors {
        static let firstColorName = "FirstColor"
    }
    
    // MARK: - CollectionView
    struct CollectionView {
        static let cellIdentifier = "CustomCollectionViewCell"
    }
    
    // MARK: - Alert Messages
    struct AlertMessages {
        static let failedToGetPreviewImage = "Failed to obtain preview image"
        static let failedToGetFileAttributes = "Failed to get file attributes"
    }
}
