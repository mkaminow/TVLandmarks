//
//  CategoryRowController.swift
//  TVLandmarks
//
//  Created by Michael Kaminowitz on 6/14/21.
//

import SwiftUI
import UIKit

enum MySection {
    case main
}

struct UICategoryRow : UIViewRepresentable {
    var items: [Landmark]

    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cvs = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvs.dataSource = context.coordinator
        cvs.delegate = context.coordinator
        cvs.register(GenericCell.self, forCellWithReuseIdentifier: "cell")
        return cvs
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }



    class Coordinator: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 155, height: 155)
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GenericCell
            let landmark = items[indexPath.item]
            cell.customView?.rootView = CategoryItem(landmark: landmark)
            return cell
        }

        var parent: UICategoryRow
        var items = [Landmark]()
        
        init(_ view: UICategoryRow) {
            parent = view
            items = view.items
        }
    }
}

class GenericCell: UICollectionViewCell {

    var item: CategoryItem?
    var customView: UIHostingController<CategoryItem>?

    init(_ landmark: Landmark) {
        let myItem = CategoryItem(landmark: landmark)
        self.item = myItem
        super.init(frame: .zero)
        customView = UIHostingController(rootView: myItem)
        customView!.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView!.view)

        customView!.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customView!.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        customView!.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        customView!.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        let myItem = CategoryItem(landmark: ModelData().landmarks[0])
        self.item = myItem
        customView = UIHostingController(rootView: myItem)
        customView!.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView!.view)

        customView!.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customView!.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        customView!.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        customView!.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
