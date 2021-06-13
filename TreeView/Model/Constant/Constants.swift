//
//  Constants.swift
//  TreeView
//
//  Created by Barsan Baidya on 6/12/21.
//

import UIKit

class Constants: NSObject {
    // MARK: - Constatnt Strings
    struct ConstStr {
        static let successCode                           = 1  // success return0
        static let failedCode                            = 0  // failed return
    }
    //====================================END of Constant =======================================
    
    // MARK: - Error & Alert Message String
    struct AlertStr {
        static let internetConnectionCheckKey            = "Please check your internet connection!"
        static let alertOptionOkayKey                    = "Ok"
        static let errorMsgKey                           = "Something went wrong!"
    }
    //====================================END of Alert String =======================================
    
    // MARK: - Web Api Method Name
    struct WebAPIMethodName {
        // Home Data
        static let webApiMethodHomeData        = "role/planning/0"
    }
    //====================================END of api method name=========================================
    
    // MARK: - Web Api Request Param
    struct WebAPIRequestParam {
        // Home Data
    }
    //====================================END of API request param========================================
    
    // MARK: - Web Api Response Param
    struct WebAPIResponseParam {
        static let reqResResultKey                       = "result"
        static let reqResStatusKey                       = "status"
        static let reqResErrorKey                        = "errors"
        static let reqResMessageKey                      = "message"
        static let reqResDataKey                         = "data"
        static let reqResSuccessKey                      = "success"
    }
    //====================================END of API response param =======================================
    
    // MARK: - Web Api Response State
    struct WebAPISuccessState {
        // Home Data
        static let successStateHomeData       = "home-data-successState"
    }
    //====================================END of API response state =======================================
}
