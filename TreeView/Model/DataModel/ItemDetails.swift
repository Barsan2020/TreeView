//
//  ItemDetails.swift
//  TreeView
//
//  Created by Barsan Baidya on 6/12/21.
//

import Foundation

class ItemDetails: NSObject,Codable {

    var horizontal_image: String
    var vertical_image: String

    enum CodingKeys:String, CodingKey {
        //Encoding/decoding will only include the properties defined in this enum, rest will be ignored
        case horizontal_image
        case vertical_image
    }

    override init() {
        self.horizontal_image = ""
        self.vertical_image = ""
    }

    init(horizontal_img:String = "", vertical_img:String = "")
    {
        self.horizontal_image = horizontal_img
        self.vertical_image = vertical_img
    }

}
