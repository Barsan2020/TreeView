//
//  Connection.swift
//  TreeView
//
//  Created by Barsan Baidya on 6/12/21.
//

import UIKit
import Alamofire

protocol ConnectionDelegate: class {
    func connectionDidFinish(nState: String,nData:[String: Any])
    func connectionDidFail(nDataError: Error,nData:String)
}

class Connection: NSObject {
    weak var delegate: ConnectionDelegate?
    static var sharedInstance: Connection?
    static var BASE_URL: String = ""
    
    class func sharedConnectionWithDelegate(delegate: AnyObject)->Connection {
        sharedInstance = Connection()
        sharedInstance?.delegate = delegate as? ConnectionDelegate
        _ = Bundle.main.bundleIdentifier!
        
        BASE_URL = "http://planningpro.dedicateddevelopers.us/api/"
        
        return sharedInstance!
    }
    class func sharedConnection() -> Connection {
        sharedInstance = Connection()
        return sharedInstance!
    }
    
    // MARK: - API Methods
    // Get List of Data
    func callFetchData() {
        let reqUrl: String = Connection.BASE_URL + Constants.WebAPIMethodName.webApiMethodHomeData
        requestWithURLGETMethod(requestURL: reqUrl, state: Constants.WebAPISuccessState.successStateHomeData, accessCode: "")
    }
    
    // MARK: - General Methods
    //GET Method
    func requestWithURLGETMethod(requestURL: String,state: String, accessCode: String) {
        if Utility.isConnected()
        {
            print("Request API:\(requestURL) ")
            var headerDict = HTTPHeaders()            
            headerDict["Content-Type"] = "application/json"
            headerDict["Accept"] = "application/json"
            headerDict["Authorization"] = "Bearer 739|c0DxqQa9nURCa2OSMMgxAdyEMdLre0JCscuXpTYz"
            
            AF.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default,headers: headerDict).validate().responseJSON { (responseJson) in
                let statusCode = responseJson.response?.statusCode
                print("API:\(requestURL) , Status Code: \(String(describing: statusCode)) Response : \(String(describing: responseJson.result))")
                
                if responseJson.value != nil//.isSuccess
                {
                    //Success
                    if let json = responseJson.value as? [String: AnyObject] {
                        //print(json)
                        self.delegate?.connectionDidFinish(nState: state, nData: json)
                    }
                }
                else
                {
                    // failure occured
                    self.delegate?.connectionDidFail(nDataError: responseJson.error!, nData: (responseJson.error?.localizedDescription) ?? "Error-Failed in response")
                }
            }
        }
        else
        {
            let errorTemp: NSError = NSError(domain: "", code: 0, userInfo: nil)
            self.delegate?.connectionDidFail(nDataError: errorTemp, nData:(Constants.AlertStr.internetConnectionCheckKey as NSString) as String)
        }
    }
}
