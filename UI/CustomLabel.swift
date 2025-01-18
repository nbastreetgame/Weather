//
//  CustomLabel.swift
//  WeatherStore
//
//  Created by Андрей Попов on 18.01.2025.
//

import Foundation
import UIKit
// MARK: - CustomLabel
class CustomLabel: UILabel {
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = .center
        self.numberOfLines = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
