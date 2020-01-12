//
//  Article.swift
//  RSSParser
//
//  Created by Tarek Sanger on 2018-04-28.
//  Copyright © 2018 Tarek Sanger. All rights reserved.
//

import Foundation
import UIKit

struct Article {
    
    var title: String
    var link: String//URL!
    var pubDate: String//Date
    var creater: String
    var catagory: String
    
    //var isPermaLink: URL?
    
    var description: String
    var content: String
    var source: String
    
    var image: UIImage?
    
    
    
    mutating func set(element: String, with content: String) {
        switch element {
        case "title":
            title = content
        case "link":
            link = content
        case "pubDate":
            pubDate = content
        default:
            break
        }
    }
    
    
}
