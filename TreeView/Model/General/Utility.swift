//
//  Utility.swift
//  TreeView
//
//  Created by Barsan Baidya on 6/12/21.
//

import UIKit
import Reachability

class Utility: NSObject {
    
    class func isConnected() -> Bool {
        let reachability = try? Reachability()
        
        switch reachability?.connection {
        case .wifi:
            print("Reachable via WiFi")
            return true
        case .cellular:
            print("Reachable via Cellular")
            return true
        case .unavailable:
            print("Network not reachable")
            return false
        default :
            return false
        }
    }
    
    class func showAlertMessage(currentView: UIViewController , errorMsg : String , errorMsgTitle: String)
    {
        let alert = UIAlertController(title: errorMsgTitle, message: errorMsg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: Constants.AlertStr.alertOptionOkayKey, style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: {
            })
        }))
        
        currentView.present(alert, animated: true, completion: nil)
    }
}
