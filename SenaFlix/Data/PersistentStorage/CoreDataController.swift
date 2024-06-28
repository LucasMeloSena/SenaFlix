//
//  CoreDataController.swift
//  SenaFlix
//
//  Created by Lucas Sena on 27/06/24.
//

import Foundation
import CoreData

class CoreDataController {
    var delegate: CoreDataControllerDelegate?
    
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(_ context: NSManagedObjectContext, with request: NSFetchRequest<Favorites> = Favorites.fetchRequest(), predicate: NSPredicate? = nil) {
        do {
            let result = try context.fetch(request)
            delegate?.loadFavoritesMovies(result)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func remove(_ context: NSManagedObjectContext, from id: NSManagedObjectID) {
        do {
            let objectToDelete = try context.existingObject(with: id)
            context.delete(objectToDelete)
            try context.save()
        }
        catch {
            print("Error deleting favorite movie \(error)")
        }
    }
}
