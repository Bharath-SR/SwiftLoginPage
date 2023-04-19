//
//  MenuOption.swift
//  SideMenu
//
//  Created by YE002 on 12/04/23.
//
import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Profile
    case Inbox
    case Notificationss
    case Signout
    
    var description: String {
        switch self {
        case .Profile: return "Profile"
        case .Inbox: return "Inbox"
        case .Notificationss: return "Notificationss"
        case .Signout: return "Signout"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Profile: return UIImage(systemName: "person.circle") ?? UIImage()
        case .Inbox: return UIImage(systemName: "square.and.pencil") ?? UIImage()
        case .Notificationss: return UIImage(systemName:  "bell") ?? UIImage()
        case .Signout: return UIImage(systemName: "rectangle.portrait.and.arrow.forward") ?? UIImage()
        }
    }
    
}
