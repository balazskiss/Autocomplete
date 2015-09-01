//
//  AutocompleteTextField.swift
//  Autocomplete
//
//  Created by Balázs Kiss on 05/08/15.
//  Copyright (c) 2015 Balázs Kiss. All rights reserved.
//

import UIKit

public protocol AutocompleteDataSource {
    func itemsForText(text:String) -> [String]
}

public protocol AutocompleteResultsViewDelegate {
    func resultsView(resultsView:AutocompleteResultsView, didSelectItem item:String)
}

public protocol AutocompleteResultsView {
    var items : [String] {get set}
    var keyword : String {get set}
    var view : UIView {get}
    var selectionDelegate : AutocompleteResultsViewDelegate? {get set}
}

public class AutocompleteTextField: UITextField, UITextFieldDelegate, AutocompleteResultsViewDelegate {

    public var resultsView : AutocompleteResultsView
    public var tableViewFrame: CGRect? {
        didSet {
            if let tableViewFrame = tableViewFrame {
                resultsView.view.frame = tableViewFrame
            }
        }
    }
    public var dataSource: AutocompleteDataSource = AutocompleteStringDataSource()
    
    public required init(coder aDecoder: NSCoder) {
        resultsView = AutocompleteTableView(frame: CGRectMake(0, 100, 320, 200), style: UITableViewStyle.Plain)
        super.init(coder: aDecoder)
        
        addTarget(self, action: "valueChange:", forControlEvents: UIControlEvents.EditingChanged)

        resultsView.selectionDelegate = self
        resultsView.view.hidden = true
        delegate = self
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        superview?.addSubview(resultsView.view)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if (tableViewFrame == nil) {
            var rect = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, 200)
            resultsView.view.frame = rect
        }
        
        superview?.bringSubviewToFront(resultsView.view)
    }
    
    func valueChange(sender:UITextField) {
        resultsView.keyword = text
        if !text.isEmpty {
            var items = dataSource.itemsForText(text)
            resultsView.items = items
            resultsView.view.hidden = (items.count == 0)
        }else{
            resultsView.view.hidden = true
        }
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        resultsView.view.hidden = true
    }
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        resultsView.view.hidden = true
        return true
    }
    
    public func resultsView(resultsView:AutocompleteResultsView, didSelectItem item:String) {
        self.text = item
        resultsView.view.hidden = true
    }

}
