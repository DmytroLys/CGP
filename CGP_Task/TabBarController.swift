//
//  TabBarController.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 12.09.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        setupTabBarColors()
    }
    
    private func setUpTabs () {
        let files = self.createNav(with: "Files", and: UIImage(systemName: "doc.on.doc"), vc: FilesViewController())
        let tools = self.createNav(with: "Tools", and: UIImage(systemName: "wrench.and.screwdriver"), vc: ToolsViewController())
        let account = self.createNav(with: "Account", and: UIImage(systemName: "person.crop.square"), vc: AccountViewController())
        
        
        self.setViewControllers([files,tools,account], animated: true)
    }
    
    private func setupTabBarColors() {
        self.tabBar.tintColor = UIColor(named: "FirstColor")
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.backgroundColor = .systemBackground
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
    
        return nav
    }
    
}
