//
//  RootViewController.swift
//  Sunshine
//
//  Created by Mikołaj Skawiński on 17.02.2017.
//  Copyright © 2017 Mikołaj Skawiński. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum RootViewType: Int {
        
        case Now = 0
        case Day
        case Week
        
        static var count: Int {
            return RootViewType.Week.rawValue + 1
        }
    }
    
    private let dataManager = DataManager(baseURL: API.AuthenticatedBaseURL)
    
    var aspectRatio: CGFloat {
        
        switch traitCollection.horizontalSizeClass {
        case .compact:
            
            return 1.0
        default:
            
            return 1.0 / 3.0
        }
    }
    
    let minimumInteritemSpacingForSection: CGFloat = 0.0
    let minimumLineSpacingForSection: CGFloat = 0.0
    let insetForSection = UIEdgeInsets()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        // Fetch Weather Data
        
        dataManager.weatherDataForLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude) {(response, error) in print(response)}
    }
    
    // MARK: - Collection View Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return RootViewType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let type = RootViewType(rawValue: indexPath.item) else {
            
            return UICollectionViewCell()
        }
        
        switch  type {
        case .Now:
            
            // Dequeue Reusable Cell
            
            return collectionView.dequeueReusableCell(withReuseIdentifier: NowCollectionViewCell.ReuseIdentifier , for: indexPath as IndexPath)
            
        case .Day:
            
            // Dequeue Reusable Cell
            
            return collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.ReuseIdentifier , for: indexPath as IndexPath)
            
        case .Week:
            
            // Dequeue Reusable Cell
            return collectionView.dequeueReusableCell(withReuseIdentifier: WeekCollectionViewCell.ReuseIdentifier , for: indexPath as IndexPath)
        }
        
    }
    
    // MARK: - Collection View Delegate Flow Layout Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        
        return CGSize(width: (bounds.width * aspectRatio), height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return minimumInteritemSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return minimumLineSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return insetForSection
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(NowCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: NowCollectionViewCell.ReuseIdentifier)
        collectionView.register(DayCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: DayCollectionViewCell.ReuseIdentifier)
        collectionView.register(WeekCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: WeekCollectionViewCell.ReuseIdentifier)
    }
    
    // MARK: - Content Container Methods
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}
