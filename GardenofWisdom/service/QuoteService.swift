//
//  QuoteService.swift
//  GardenofWisdom
//
//  Created by Miami Jaboori on 2024-01-05.
//

import FirebaseFirestore

class QuoteService {
    static let shared = QuoteService() // Singleton obj
    
    private let db = Firestore.firestore()
    
    
    func addCategory(categoryObj: MainCategory) -> Bool {
        
        do {
             try db.collection("MainCategory").addDocument(from: categoryObj)
                return true
        } catch {
            print("Error adding main category")
            return false
        }
        
    }
    
    
    func addCategoryItem(mainCategoryItemObj: MainCategoryItem ) -> Bool{
        do {
             try db.collection("MainCategoryItem").addDocument(from: mainCategoryItemObj)
                return true
        } catch {
            print("Error adding main category items")
            return false
        }
    }
    
    
    
    
}
