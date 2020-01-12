//
//  RSSParser.swift
//  RSSParser
//
//  Created by Tarek Sanger on 2018-04-26.
//  Copyright © 2018 Tarek Sanger. All rights reserved.
//

import Foundation


extension String {
    func deleteHTML(tag: String) -> String {
        return self.replacingOccurrences(of: "(?i)</?\(tag)\\b[^<]*>", with: "", options: .regularExpression, range: nil)
    }
    
    func deleteHTML(tags:[String]) -> String {
        var mutableString = self
        for tag in tags {
            mutableString = mutableString.deleteHTML(tag: tag)
        }
        return mutableString
    }
}


class RSSParser: NSObject, XMLParserDelegate {
    var xmlParser: XMLParser!
    var currentElement = ""          /* <- Holds the value for the current XML tag */
    var foundCharacters = ""        /* <- represesnts the value of said tag */
    var currentData = [String:String]() /* <- reconstructed feed item(s) */
    var parsedData = [[String:String]]() /* <- Complete entries (represesnts the entirety of a single feed) */
    var isHeader = true                 /* <- Header flag */
    
    
    
    func startParsingWithContentOfURL(rssURL: URL, with completion: (Bool) -> ()) {
        
        let parser = XMLParser(contentsOf: rssURL)
        parser?.delegate = self
        if let flag = parser?.parse() {
            // handle last item in feed
            parsedData.append(currentData)
            completion(flag)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        //new items start at <item> tag we're not interested int header
        if currentElement == "item" || currentElement == "entry" {
            
            // at this point we're working with n+1 entry
            if isHeader == false {
                parsedData.append(currentData)
            }
            
            isHeader = false
        }
        
        if isHeader == false {
            // handle article thimbnails
            if currentElement == "media:thumbnail" || currentElement == "media:content" {
                foundCharacters += attributeDict["url"]!
            }
        }
        
    }
    
    
    // keep relevent tag content
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isHeader == false {
            
            if currentElement == "title" || currentElement == "link" || currentElement == "description" || currentElement == "content" || currentElement == "pubDate" || currentElement == "auther" || currentElement == "dc:creater" || currentElement == "content:encoded" {
                
                foundCharacters += string
                foundCharacters = foundCharacters.deleteHTML(tags: ["a", "p", "div", "img", "title", "["])
            }
        }
    }
    
    // look at closing tag
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            print("Element Ended: \(elementName) \t\t CurrentElement: \(currentElement) \n")
            foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            currentData[currentElement] = foundCharacters
            foundCharacters = ""
            
        }
    }
    
}
