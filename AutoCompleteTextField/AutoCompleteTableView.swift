//
//  AutoCompleteTableView.swift
//  AutoCompleteTextField
//
//  Created by Balázs Kiss on 11/08/15.
//  Copyright (c) 2015 Balázs Kiss. All rights reserved.
//

import UIKit

class AutoCompleteTableView: UITableView, UITableViewDataSource, AutoCompleteResultsView, UITableViewDelegate {
    
    var items:[String] = [] {
        didSet {
            self.reloadData()
        }
    }
    var keyword:String = ""
    var selectionDelegate:AutoCompleteResultsViewDelegate?
    var view: UIView {
        get {
            return self
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        configure()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        delegate = self
        dataSource = self
        registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 5
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let item = items[indexPath.row]
        let text = NSMutableAttributedString(string: item)
        let font = UIFont.boldSystemFontOfSize(cell.textLabel!.font.pointSize)
        text.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: count(keyword)))
        cell.textLabel!.attributedText = text
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = items[indexPath.row]
        selectionDelegate?.resultsView(self, didSelectItem: item)
    }

}
