//
//  FlowViewController.swift
//  CompositionalLayout
//
//  Created by Егоров Михаил on 08.05.2023.
//

import UIKit

class FlowViewController: UIViewController {
    
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        //Начальная инициализация для CollectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // добавляем на экран
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension FlowViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

// MARK: - DelegateFlowLayout - задает размеры для ячеек
extension FlowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
}

// MARK: - SwiftUI Canvas
import SwiftUI
struct FlowProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let tabBar = MainTabbarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) -> MainTabbarController {
            return tabBar
        }
        func updateUIViewController(_ uiViewController: FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) {
            
        }
    }
}
