//
//  SearchResultsTableViewController.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import FoldingCell

class SearchResultsTableViewController: UITableViewController {
    
    
    let rowsCount = 2 // count of tickets later
    var cellHeights: [CGFloat] = []
    var expandedCellIndexPath: IndexPath?
    var ticketRequestModel = TicketRequestModel()
    
    let closeCellHeight: CGFloat = 120
    let openCellHeight: CGFloat = 269
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        cellHeights = Array(repeating: closeCellHeight, count: rowsCount) // add amount of ticket count in response
        tableView.estimatedRowHeight = closeCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension // TODO: Need to know more about it
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        tableView.backgroundView?.contentMode = .scaleAspectFit // FIXME: .scaleAspectFit now working
        tableView.separatorColor = .clear
    }
}

extension SearchResultsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as CustomFoldingCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        let closed = cellHeights[indexPath.row] == closeCellHeight
        cell.unfold(!closed, animated: false, completion: nil)
        cell.number = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketResultCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let path = expandedCellIndexPath, let expandedCell = tableView.cellForRow(at: path) as? FoldingCell {
            expandedCell.unfold(false, animated: true, completion: nil)
            cellHeights[path.row] = closeCellHeight
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                tableView.beginUpdates()
                tableView.endUpdates()
            }, completion: nil)
            expandedCellIndexPath = nil
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? FoldingCell else { return }
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = openCellHeight
            cell.unfold(true)
            duration = 0.5
            expandedCellIndexPath = indexPath
        } else {
            cellHeights[indexPath.row] = closeCellHeight
            cell.unfold(false)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    
}
