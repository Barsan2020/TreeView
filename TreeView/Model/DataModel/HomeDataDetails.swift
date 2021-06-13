//
//  HomeDataDetails.swift
//  TreeView
//
//  Created by Barsan Baidya on 6/12/21.
//

import Foundation

class HomeDataDetails: NSObject {
    var colour: String
    var company: String
    var created_at: String
    var deleted_at: String
    var id: Int
    var order: Int
    var planning: Dictionary<String, Any>
    var role_name: String
    var role_type: Int
    var updated_at: String
    var user_id: Int
    var open_role: Bool
    var open_objective: Bool
    
    
    enum CodingKeys:String, CodingKey {
        //Encoding/decoding will only include the properties defined in this enum, rest will be ignored
        case colour
        case company
        case created_at
        case deleted_at
        case id
        case order
        case planning
        case role_name
        case role_type
        case updated_at
        case user_id
        case open_role
        case open_objective
    }
    
    override init() {
        self.colour = ""
        self.company = ""
        self.created_at = ""
        self.deleted_at = ""
        self.id = 0
        self.order = 0
        self.planning = [:]
        self.role_name = ""
        self.role_type = 0
        self.updated_at = ""
        self.user_id = 0
        self.open_role = false
        self.open_objective = false
    }
    
    init(hColour: String = "", hCompany: String = "", hCreated_at: String = "", hDeleted_at: String = "", hId: Int = 0, hOrder: Int = 0, hPlanning: Dictionary<String, Any> = [:], hRole_name: String = "", hRole_type: Int = 0, hUpdated_at: String = "", hUser_id: Int = 0, hOpen_role: Bool = false, hOpen_objective: Bool = false)
    {
        self.colour = hColour
        self.company = hCompany
        self.created_at = hCreated_at
        self.deleted_at = hDeleted_at
        self.id = hId
        self.order = hOrder
        self.planning = hPlanning
        self.role_name = hRole_name
        self.role_type = hRole_type
        self.updated_at = hUpdated_at
        self.user_id = hUser_id
        self.open_role = hOpen_role
        self.open_objective = hOpen_objective
    }
}
