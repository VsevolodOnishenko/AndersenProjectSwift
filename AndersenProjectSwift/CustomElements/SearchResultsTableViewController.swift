//
//  SearchResultsTableViewController.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//
import UIKit
import CoreData

class SearchResultsTableViewController: UITableViewController {
    
    var cellHeights: [CGFloat] = [] //del
    var expandedCellIndexPath: IndexPath? //del
    var ticketRequestModel = TicketRequestModel()
    var placeFullNameModel = PlaceFullNameModel()
    var customDataSource = CustomDataSource() //del
    var ticketArray: [Any] = [] { //del
        didSet {
            setup()
            setupDataSourceParameters()
        }
    }
    
    enum CellHeight: CGFloat {     //del
        case closeCellHeight = 120
        case openCellHeight = 269
    }
    
    let cellIdentifier = "ticketResultCell" //del
    var searchResultsViewModel = SearchResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = customDataSource //viewModelDataSource
        tableView.delegate = customDataSource   //viewModelDataSource
    }
    
    //TODO: ASK ABOUT TabBar selected index
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        detectData() //viewModel.detectData
        tableView.reloadData()
    }
    
    private func setupDataSourceParameters() {
        
        customDataSource.dataSourceCellHeights = cellHeights
        customDataSource.dataSourceTicketArray = ticketArray
        customDataSource.dataSourceTicketIdentifier = cellIdentifier
        customDataSource.dataSourcePlaceFullName = placeFullNameModel
        customDataSource.dataSourceExpandedCellIndexPath = expandedCellIndexPath
        CustomDataSource.CellHeight.closeCellHeight = CellHeight.closeCellHeight.rawValue
        CustomDataSource.CellHeight.openCellHeight = CellHeight.openCellHeight.rawValue
        
    }
    
    private func setup() {
        
        cellHeights = Array(repeating: CellHeight.closeCellHeight.rawValue, count: ticketArray.count)
        tableView.estimatedRowHeight = CellHeight.closeCellHeight.rawValue
        tableView.rowHeight = UITableViewAutomaticDimension // TODO: Need to know more about it
        let backgroundView = UIImageView(image: #imageLiteral(resourceName: "background"))
        tableView.backgroundView = backgroundView
        tableView.backgroundView?.contentMode = .scaleAspectFill
        tableView.backgroundView?.alpha = 0.65
        tableView.separatorColor = .clear
        
    }
    
    private func fetchTicketArray() {
        
        let response = ResponseDataModel()
        response.fetchResponse(ticketRequestModel: ticketRequestModel) {
            models in self.ticketArray = models.map{$0}
            
        }
    }
    
    private func fetchCoreDataArray() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket")
        
        do {
            guard let fetchArray = try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
                as? [Ticket] else { return }
            
            ticketArray = fetchArray.map{$0}
            
        } catch {
            assertionFailure()
        }
    }
    
    //later clearing entity will be with gesture
    
    @IBAction private func clearCoreData(_ sender: UIButton) {
        
        let context = CoreDataManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket")
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject] //avoid force unwrapping later
            
            for item in items {
                context.delete(item)
            }
            try context.save()
            
        } catch {
            assertionFailure()
        }
    }
    
    private func detectData() {
        
        if tabBarController?.selectedIndex == 0 {
            fetchTicketArray()
            
        } else {
            fetchCoreDataArray()
        }
    }
}
