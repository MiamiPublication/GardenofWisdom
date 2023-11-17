import SwiftUI



struct ContentView: View {

    @State private var categories: [Category] = []

    @State private var isAddingCategory = false

    @State private var isAddingSubcategory = false

    @State private var newCategoryName = ""

    @State private var newSubcategoryName = ""

    @State private var selectedCategoryIndex = 0

    @State private var selectedSubcategoryColor: Color = .white // Default color



    var body: some View {

        NavigationView {

            ZStack {

                List {

                    ForEach(categories.indices, id: \.self) { index in

                        Section {

                            HStack {

                                Text(categories[index].name)

                                Spacer()

                                Button(action: {

                                    deleteCategory(at: index)

                                }) {

                                    Image(systemName: "trash")
                                        

                                }
                                .foregroundColor(.red)

                            }

                            ForEach(categories[index].subcategories.indices, id: \.self) { subcategoryIndex in

                                let subcategory = categories[index].subcategories[subcategoryIndex]

                                let color = categories[index].subcategoriesColors[subcategoryIndex]

                                HStack {

                                    Text(subcategory)

                                    Spacer()

                                    ColorButton(color: color) { selectedColor in

                                        selectedSubcategoryColor = selectedColor

                                    }

                                }

                            }

                        }

                    }

                }

                .listStyle(GroupedListStyle())

                .navigationBarTitle("Color List Application")

                .navigationBarItems(trailing:

                    HStack {

                        Button(action: {

                            isAddingCategory = true

                        }) {

                            Text("Add Category")

                        }



                        Button(action: {

                            isAddingSubcategory = true

                        }) {

                            Text("Add Subcategory")

                        }

                    }

                )

                // Overlay to represent the selected color

                .overlay(

                    RoundedRectangle(cornerRadius: 10)

                        .foregroundColor(Color(selectedSubcategoryColor))

                        .opacity(0.3)

                        .animation(.easeInOut(duration: 0.5))

                )

                .sheet(isPresented: $isAddingCategory) {

                    AddCategoryView(newCategoryName: $newCategoryName) {

                        addCategory()

                        isAddingCategory = false

                    }

                }

                .sheet(isPresented: $isAddingSubcategory) {

                    AddSubcategoryView(newSubcategoryName: $newSubcategoryName,

                                       selectedSubcategoryColor: $selectedSubcategoryColor,

                                       categories: categories,

                                       selectedCategoryIndex: $selectedCategoryIndex) {

                        addSubcategory()

                        isAddingSubcategory = false

                    }

                }

            }

        }

    }



    func addCategory() {

        let newCategory = Category(name: newCategoryName, subcategories: [], subcategoriesColors: [])

        categories.append(newCategory)
        CategoryService.sharedCategoryService.addCategory(category: newCategoryName )

        newCategoryName = ""
        
        let mainCategory = MainCategory(name: newCategory.name)
        
        QuoteService.shared.addCategory(categoryObj: mainCategory)

    }



    func addSubcategory() {

        guard selectedCategoryIndex < categories.count else {

            return

        }



        categories[selectedCategoryIndex].subcategories.append(newSubcategoryName)

        categories[selectedCategoryIndex].subcategoriesColors.append(selectedSubcategoryColor)

        
        
        let subcategory: CategoryItem = CategoryItem(name: newSubcategoryName, categoryid: "", color: "green")
        
                
        
        CategoryService.sharedCategoryService.addSubCategory(subcategory: subcategory )
        

        
        let mainCategoryObj = MainCategory(name: categories[selectedCategoryIndex].name)
        
        let mainCateogryItem = MainCategoryItem(
            id:UUID().uuidString,
            name: newSubcategoryName,
            category: mainCategoryObj,
            subcategoriesColors: selectedSubcategoryColor.toString() )
        
        QuoteService.shared.addCategoryItem(mainCategoryItemObj: mainCateogryItem)

        newSubcategoryName = ""
    }



    func deleteCategory(at index: Int) {

        categories.remove(at: index)

    }

}



struct ContentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView()

    }

}



struct AddSubcategoryView: View {

    @Binding var newSubcategoryName: String

    @Binding var selectedSubcategoryColor: Color

    var categories: [Category]

    @Binding var selectedCategoryIndex: Int

    var onSave: () -> Void



    var body: some View {

        NavigationView {

            Form {

                Section {

                    Picker("Select Category", selection: $selectedCategoryIndex) {

                        ForEach(0..<categories.count) { index in

                            Text(categories[index].name).tag(index)

                        }

                    }

                }



                Section {

                    TextField("Subcategory Name", text: $newSubcategoryName)

                    ColorPicker("Select Color", selection: $selectedSubcategoryColor)

                }

                Section {

                    Button("Save") {

                        onSave()

                    }

                }

            }

            .navigationBarTitle("Add Subcategory")

        }

    }

}







struct AddCategoryView: View {

    @Binding var newCategoryName: String

    var onSave: () -> Void



    var body: some View {

        NavigationView {

            Form {

                Section {

                    TextField("Enter Category Name", text: $newCategoryName)

                }

                Section {

                    Button("Save") {

                        onSave()

                    }

                }

            }

            .navigationBarTitle("Add Category")

        }

    }

}



struct ColorButton: View {

    var color: Color

    var onSelect: (Color) -> Void // Pass the selected color back



    var body: some View {

        Button(action: {

            onSelect(color) // Pass the selected color back to the ContentView

            

        }) {

            Circle()

                .fill(color)

                .frame(width: 30, height: 30)

        }

    }

}
