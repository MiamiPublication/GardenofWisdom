//
//  CategoryService.swift
//  GardenofWisdom
//
//  Created by Miami Jaboori on 2023-12-03.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


class CategoryService {
    
    static let sharedCategoryService = CategoryService()
    
    
    let db = Firestore.firestore()
    
    func getData(){}
    
    func addCategory(category: String){
        
        db.collection("Categories").addDocument(data: [
            "name": category
        ]){ error in
            
            if error == nil {
                print("Category added")
            }
            else {
               print ("Error")
            }
        }
        
    }
    
    func addSubCategory(subcategory: CategoryItem){
        db.collection("Subcategories").addDocument(data: [
            "name": subcategory.name,
            "color": subcategory.color,
            "categoryid": subcategory.categoryid
        ])
        
    }
    
    
}
