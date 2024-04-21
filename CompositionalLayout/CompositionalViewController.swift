//
//  CompositionalViewController.swift
//  CompositionalLayout
//
//  Created by Егоров Михаил on 08.05.2023.
//
// Compositional layout со старым DataSourсe
import Foundation
import UIKit

class CompositionalViewController: UIViewController {
    
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupCollectionView()
    }
    
    func setupCollectionView() {
        //Начальная инициализация для CollectionView
        // compositioanLAyout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // добавляем на экран
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    // второй вид layout
    private func createLayoutX() -> UICollectionViewLayout {
        //Концепт: section -> groups -> items -> size
        
        // widthDimension - поведение компонента по горизонтали 0.2 пространства от всей ширины ГРУППЫ
        // heightDimension - поведение компонента по вертикали высота items = высоте ГРУППЫ
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1.0))
        // layoutSize - размер item
        // supplementaryItems - заголовок или футер
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // отступы у items
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // widthDimension - ширина группы = ширие СЕКЦИИ
        // heightDimension - высота группы зависит от ширины СЕКЦИИ
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // по умолчанию секция занимает всю площадь layout'a
        let section = NSCollectionLayoutSection(group: group)
        // отсутпы от секции по левому и правому краю
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // layout с заданным item в строке = 2
    private func createLayout() -> UICollectionViewLayout {
        //Концепт: section -> groups -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension CompositionalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        cell.layer.borderWidth = 1
        return cell
    }
    
    //
}


// MARK: - SwiftUI Canvas
import SwiftUI
struct CompositionalProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let tabBar = MainTabbarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<CompositionalProvider.ContainterView>) -> MainTabbarController {
            return tabBar
        }
        func updateUIViewController(_ uiViewController: CompositionalProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<CompositionalProvider.ContainterView>) {
            
        }
    }
}
