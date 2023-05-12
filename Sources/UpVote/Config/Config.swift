//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 09/05/23.
//

import Foundation
import SwiftUI

public class UpVoteConfig {
    
    public static let shared = UpVoteConfig()
    
    //MARK: - logic
    public var appCode: String = ""
    public var userID: String = ""
    
    //MARK: - Colors
    
    public var textColor: Color = Color.black
    public var backgroundColor: Color = Color.black.opacity(0.03)
    public var white: Color = Color.white
    public var primaryColor: Color = Color.red
    
    
    //MARK: - Labels
    
    public var listTitle: String = "Features to vote"
    public var votesLabel: String = "votes"
    public var alreadyVoteLabel: String = "Voted"
    public var confirmButtonLabel: String = "Confirm"
    public var cancelButtonLabel: String = "Cancel"
    public var confirmTitleModal: String = "Confirm your vote"
    
    
}
