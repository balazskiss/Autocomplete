//
//  AutoCompleteStringDataSource.swift
//  AutoCompleteTextField
//
//  Created by Balázs Kiss on 11/08/15.
//  Copyright (c) 2015 Balázs Kiss. All rights reserved.
//

import UIKit

class AutoCompleteStringDataSource: NSObject, AutoCompleteDataSource {
    
    var items :[String] = []
    
    override init() {
        super.init()
    }
    
    init(items:[String]) {
        self.items = items
        super.init()
    }
    
    func itemsForText(text: String) -> [String] {
        return filterItems(text)
    }
   
    func filterItems(text:String) -> [String] {
        var filteredItems : [String] = []
        for item in items {
            if item.lowercaseString.hasPrefix(text.lowercaseString) {
                filteredItems.append(item)
            }
        }
        return filteredItems
    }
    
}
