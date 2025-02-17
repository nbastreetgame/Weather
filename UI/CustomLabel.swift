//
//  CustomLabel.swift
//  WeatherStore
//
//  Created by Андрей Попов on 18.01.2025.
//


import UIKit

final class CustomLabel: UILabel {
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize)
        textAlignment = .center
        numberOfLines = 1
        textColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
