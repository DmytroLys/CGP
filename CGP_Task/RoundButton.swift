//
//  RoundButton.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 15.09.2023.
//

import UIKit

class RoundButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRoundButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupRoundButton()
    }

    func setupRoundButton() {
        let mainColor = UIColor(named: "FirstColor") ?? UIColor.blue
        let lighterColor = mainColor.withAlphaComponent(0.85).cgColor
        
        self.setTitle("+", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        self.frame.size = CGSize(width: 60, height: 60)
        self.layer.cornerRadius = 30
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [lighterColor, mainColor.cgColor, lighterColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        gradientLayer.frame = self.bounds
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}







