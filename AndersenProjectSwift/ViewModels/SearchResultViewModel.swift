import UIKit
import CoreData

enum CellHeight: CGFloat {
    case closeCellHeight = 120
    case openCellHeight = 269
}

class SearchResultViewModel {
    
    var cellHeights: [CGFloat] = []
    var expandedCellIndexPath: IndexPath?
    var ticketRequestModel = TicketRequestModel()
    var placeFullNameModel = PlaceFullNameModel()
    var customDataSource = CustomDataSource()
    var ticketArray: [Any] = [] {
        didSet {
            
            setupDataSourceParameters()
        }
    }
    
    let cellIdentifier = "ticketResultCell"
    
    private func setupDataSourceParameters() {
        
        customDataSource.dataSourceCellHeights = cellHeights
        customDataSource.dataSourceTicketArray = ticketArray
        customDataSource.dataSourceTicketIdentifier = cellIdentifier
        customDataSource.dataSourcePlaceFullName = placeFullNameModel
        customDataSource.dataSourceExpandedCellIndexPath = expandedCellIndexPath
        CustomDataSource.CellHeight.closeCellHeight = CellHeight.closeCellHeight.rawValue
        CustomDataSource.CellHeight.openCellHeight = CellHeight.openCellHeight.rawValue
        
    }
    
    func fetchTicketArray() {
        
        let response = ResponseDataModel()
        response.fetchResponse(ticketRequestModel: ticketRequestModel) {
            models in self.ticketArray = models.map{$0}
        }
    }
    
    func fetchCoreDataArray() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket")
        
        do {
            guard let fetchArray = try CoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
                as? [Ticket] else { return }
            
            ticketArray = fetchArray.map{$0}
            
        } catch {
            assertionFailure()
        }
    }
    
    func clearFeatures() {
        
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
    
//    func detectData() {
//        
//        if tabBarController?.selectedIndex == 0 {
//            fetchTicketArray()
//            
//        } else {
//            fetchCoreDataArray()
//        }
//    }
}

