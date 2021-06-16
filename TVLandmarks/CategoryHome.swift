//
//  CategoryHome.swift
//  Landmarks
//
//  Created by Michael Kaminowitz on 5/25/21.
//

import SwiftUI
//ContentPage
struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false

    var body: some View {
        NavigationView {
            List {
                PageView(pages: modelData.features.map{ FeatureCard(landmark: $0)})
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets())
                
                CategoryRow(categoryName: "All", items: modelData.landmarks)
                VStack(alignment: .leading) {
                    Text("All but UIKit")
                        .font(.headline)
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    UICategoryRow(items: modelData.landmarks)
                        .frame(height: 215)
                        .listRowInsets(EdgeInsets())
                }
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
                .navigationTitle("Featured")
            .toolbar {
                Button(action: { showingProfile.toggle() }) {
                    Image(systemName: "person.crop.circle")
                        .accessibilityLabel("User Profile")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData)
            }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
