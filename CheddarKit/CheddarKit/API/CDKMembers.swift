//
//  CDKMembers.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/15/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

extension CheddarKit: CDKMembersProtocol {
    
    func members(inList list: CDKList, callback: @escaping (Result<CDKMembers, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/\(list.id)/members", method: "GET", params: nil, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func remove(member: CDKUser, fromList: CDKList) {
        //
    }
    
    func invitations(forUser: CDKUser) {
        //
    }
    
    func delete(invitation: CDKInvitation) {
        //
    }
    
    func accept(invitation: CDKInvitation) {
        //
    }
    
}
