//
//  CustomDataSource.swift
//  AndersenProjectSwift
//
//  Created by macbook on 08.11.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import FoldingCell

class CustomDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var dataSourceCellHeights: [CGFloat] = []
    var dataSourceTicketArray: [Any] = []
    var dataSourceTicketIdentifier = String()
    var dataSourcePlaceFullName = PlaceFullNameModel()
    var dataSourceExpandedCellIndexPath: IndexPath?
    
    enum CellHeight {
        
        static var closeCellHeight = CGFloat()
        static var openCellHeight = CGFloat()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceTicketArray.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as CustomFoldingCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        let closed = dataSourceCellHeights[indexPath.row] == CellHeight.closeCellHeight
        cell.unfold(!closed, animated: false, completion: nil)
        cell.number = indexPath.row
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: dataSourceTicketIdentifier, for: indexPath) as! CustomFoldingCell
        
        if dataSourceTicketArray is [Ticket] {
            cell.getTicketFromCoreData(coreDataTicket: dataSourceTicketArray[indexPath.row] as! Ticket)
            
        } else {
            
            cell.getTicket(ticketResponse: dataSourceTicketArray[indexPath.row] as! TicketResponseModel, placeFullName: dataSourcePlaceFullName)
        }
        
        //tableView.reloadSections(NSIndexSet(index: indexPath.row) as IndexSet, with: .bottom)
        
        tableView.reloadSectionIndexTitles()
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSourceCellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let path = dataSourceExpandedCellIndexPath, let expandedCell = tableView.cellForRow(at: path) as? FoldingCell {
            expandedCell.unfold(false, animated: true, completion: nil)
            dataSourceCellHeights[path.row] = CellHeight.closeCellHeight
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                tableView.beginUpdates()
                tableView.endUpdates()
            }, completion: nil)
            dataSourceExpandedCellIndexPath = nil
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? FoldingCell else { return }
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = dataSourceCellHeights[indexPath.row] == CellHeight.closeCellHeight
        if cellIsCollapsed {
            dataSourceCellHeights[indexPath.row] = CellHeight.openCellHeight
            cell.unfold(true)
            duration = 0.5
            dataSourceExpandedCellIndexPath = indexPath
        } else {
            dataSourceCellHeights[indexPath.row] = CellHeight.closeCellHeight
            cell.unfold(false)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)

    }

}
