//
//  UIView+toastView.swift
//  TreeView
//
//  Created by Barsan Baidya on 6/12/21.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showToastBottom(message : String) {
        let screenSize: CGRect = UIScreen.main.bounds
        let toastLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height - 45, width: screenSize.width, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Roboto-Regular", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 2;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showAlertToastBottom(message : String) {
        let screenSize: CGRect = UIScreen.main.bounds
        let toastLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height - 45, width: screenSize.width, height: 35))
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Roboto-Regular", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 2;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    func showSuccessToastBottom(message : String) {
        let screenSize: CGRect = UIScreen.main.bounds
        let toastLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height - 45, width: screenSize.width, height: 35))
        //toastLabel.backgroundColor = UIColor.MedRecColor.defaultBottleGreenColor.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Roboto-Regular", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 2;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
