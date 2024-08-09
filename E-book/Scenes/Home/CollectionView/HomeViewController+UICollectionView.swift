//
//  HomeViewController+UICollectionView.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 26.07.24.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    static func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            sectionIndex == 0 ? Self.createCategorySection() : Self.createBookSection()
        }
        layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: SectionBackgroundDecorationView.identifier)
        return layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return configureCategoryCell(collectionView, indexPath: indexPath)
        case 1:
            return configureBookCell(collectionView, indexPath: indexPath, book: viewModel.recommendedBook(at: indexPath))
        default:
            return configureBookCell(collectionView, indexPath: indexPath, book: viewModel.newBook(at: indexPath))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
        
        let (title, count) = sectionHeaderTitleAndCount(for: indexPath.section)
        headerView.configure(title: title, count: count)
        headerView.onAction = { [weak self] in
            self?.navigationController?.pushViewController(BooksViewController(), animated: true)
        }
        
        return headerView
    }
    
    private func configureCategoryCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(viewModel.category(at: indexPath))
        return cell
    }
    
    private func configureBookCell(_ collectionView: UICollectionView, indexPath: IndexPath, book: BookShortInfo) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(book)
        return cell
    }
    
    private func sectionHeaderTitleAndCount(for section: Int) -> (String, String) {
        switch section {
        case 1:
            return ("Рекомендуем", "\(viewModel.recommendedBooks.count)")
        default:
            return ("Новинки этой недели", "\(viewModel.newBooks.count)")
        }
    }
    
    private static func createCategorySection() -> NSCollectionLayoutSection {
        let item = createItem()
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private static func createBookSection() -> NSCollectionLayoutSection {
        let item = createItem()
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(227))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 12, bottom: 40, trailing: 12)
        
        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]
        
        let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundDecorationView.identifier)
        sectionBackground.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        section.decorationItems = [sectionBackground]
        
        return section
    }
    
    private static func createItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        return item
    }
    
    private static func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(57))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        return header
    }
    
}
