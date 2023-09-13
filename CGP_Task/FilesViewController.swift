//
//  ViewController.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 12.09.2023.
//

import UIKit

class FilesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupNavigationBarTitle()
        addRightBarButtonItems()
        setUpAddButton()
    }
    
    private func  setupNavigationBarTitle() {
        
        let titleLabel = UILabel()
        
        let attributedString = NSAttributedString(string: "My Files", attributes: [
            .font: UIFont.systemFont(ofSize: 26, weight: .bold),
            .foregroundColor: UIColor.black,
        ])
        
        titleLabel.attributedText = attributedString
        let baritem = UIBarButtonItem(customView: titleLabel)
        
        self.navigationItem.setLeftBarButton(baritem, animated: true)
    }
    
    func addRightBarButtonItems() {
            
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .default)
        
        let buttonOne = UIButton(type: .custom)
        buttonOne.frame.size = CGSize(width: 36, height: 36)
        let imageBell = UIImage(systemName: "bell",withConfiguration: config)
        buttonOne.setImage(imageBell, for: .normal)
        buttonOne.tintColor = UIColor(named: "FirstColor")
        
        let buttonTwo = UIButton(type: .custom)
        let imageEllipsis = UIImage(systemName: "ellipsis", withConfiguration: config)
        buttonTwo.setImage(imageEllipsis, for: .normal)
        buttonTwo.tintColor = UIColor(named: "FirstColor")
        
        applyCommonStyles(to: buttonOne)
        applyCommonStyles(to: buttonTwo)
        
        let stackview = UIStackView(arrangedSubviews: [buttonOne, buttonTwo])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 10
        
        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }

    func applyCommonStyles(to button: UIButton) {
        button.backgroundColor = .clear
        button.widthAnchor.constraint(equalToConstant: 36).isActive = true
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.widthAnchor.constraint(equalToConstant: 36).isActive = true
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.contentEdgeInsets = UIEdgeInsets(top: button.contentEdgeInsets.top + 5, left: button.contentEdgeInsets.left + 5, bottom: button.contentEdgeInsets.bottom + 5, right: button.contentEdgeInsets.right + 5)
        button.layer.borderColor = UIColor.gray.cgColor
    }

    
    private func setUpAddButton() {
        
    }
}

