//
//  AdvancedViewController.swift
//  CompositionalLayout
//
//  Created by Егоров Михаил on 08.05.2023.
//
// Compositional layout с DiffableDataSource для разработки интерфейса с несколькими секциями
import Foundation
import UIKit

class AdvancedViewController: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case list, grid3
        var columnCount: Int {
            switch self {
            case .list:
                return 2
            case .grid3:
                return 3
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupCollectionView()
    }
    
    func setupCollectionView() {
        //Начальная инициализация для CollectionView
        // compositionLayout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        // добавляем на экран
        view.addSubview(collectionView)
        
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.reuseId)
        
        setupDataSource()
        reloadData()
        
        collectionView.delegate = self
        
    }
    
    func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Error \(cellType)")
        }
        return cell
    }
    // MARK: - Manage the data in UICollectionView
    // инициализация DataSource
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, intValue in
            let section = SectionKind(rawValue: indexPath.section)!
            switch section {
            case .list:
                return self.configure(cellType: UserCell.self, with: intValue, for: indexPath)
            case .grid3:
                return self.configure(cellType: FoodCell.self, with: intValue, for: indexPath)
            }
        })
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        // 10 item на секцию
        let itemsPerSection = 10
        SectionKind.allCases.forEach { sectionKind in
            let itemOffSet = sectionKind.columnCount * itemsPerSection
            let itemUpperbound = itemOffSet + itemsPerSection
            snapshot.appendSections([sectionKind])
            snapshot.appendItems(Array(itemOffSet..<itemUpperbound))
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - Setup Layout
    // layout с заданным item в строке = 2
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            let section = SectionKind(rawValue: sectionIndex)!
            switch section {
            case .list:
                return self.createListSection()
            case .grid3:
                return self.createGridSection()
            }
        }
        // делаем разрыв между секциями
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 50
        layout.configuration = config
        return layout
    }
    
    private func createListSection() -> NSCollectionLayoutSection {
        //Концепт: section -> groups -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(20)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

        return section
    }
    
    private func createGridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(104),
                                                    heightDimension: .estimated(88))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 12, bottom: 0, trailing: 12)
        
        return layoutSection
    }
}
extension AdvancedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
    }
}

// MARK: - SwiftUI Canvas
import SwiftUI
struct AdvancedProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let tabBar = MainTabbarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<AdvancedProvider.ContainterView>) -> MainTabbarController {
            return tabBar
        }
        func updateUIViewController(_ uiViewController: AdvancedProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<AdvancedProvider.ContainterView>) {
            
        }
    }
}
