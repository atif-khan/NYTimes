//
//  StoryboardLoadable.swift
//  NYTimes
//
//  Created by Atif Khan on 16/09/2021.
//

import Foundation
import UIKit

protocol StoryboardLoadable {
    static func storyboardName() -> String
    static func storyboardIdentifier() -> String
}

extension StoryboardLoadable where Self: UIViewController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }

    static func storyboardIdentifier() -> String {
        return String(describing: Self.self)
    }
}

extension StoryboardLoadable where Self: UITableViewController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "TableViewController", with: "")
    }

    static func storyboardIdentifier() -> String {
        return String(describing: Self.self)
    }
}
