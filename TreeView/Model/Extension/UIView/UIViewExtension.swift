//
//  UIViewExtension.swift
//  TreeView
//
//  Created by Barsan Baidya on 6/12/21.
//

import Foundation
import UIKit

extension UIView {
    // Remove allSubView in view
    func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func circularView()
    {
        self.layer.cornerRadius = self.layer.frame.width/2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
    }
}
