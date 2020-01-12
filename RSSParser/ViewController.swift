//
//  ViewController.swift
//  RSSParser
//
//  Created by Tarek Sanger on 2018-04-26.
//  Copyright © 2018 Tarek Sanger. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let rssParser = RSSParser()
        rssParser.startParsingWithContentOfURL(rssURL: URL(string: "https://www.nationalnewswatch.com/feed/")!, with: mybool)
        if let string = rssParser.parsedData[0]["title"] {
            print("\(string)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mybool(_ flag: Bool){
        if flag {
            
        }
        
    }
    

}

