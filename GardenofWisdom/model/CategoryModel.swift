//
//  CategoryModel.swift
//  GardenofWisdom
//
//  Created by Miami Jaboori on 2023-12-03.
//

import SwiftUI


struct Category: Identifiable {

    var id = UUID()

    var name: String

    var subcategories: [String]

    var subcategoriesColors: [Color]
    
    var categoryid = ""

}

struct MainCategory: Identifiable, Codable {
    var id: String?
    let name: String
}

struct MainCategoryItem: Identifiable, Codable {
    let id : String?
    let name: String
    let category: MainCategory
    let subcategoriesColors: String
}

struct CategoryItem{
    
    var name : String
    var categoryid: String
    var color : String
    
}



