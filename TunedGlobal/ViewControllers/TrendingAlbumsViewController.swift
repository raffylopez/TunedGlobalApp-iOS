//
//  TrendingAlbumsViewController.swift
//  TunedGlobal
//
//  Copyright © 2021 Raf. All rights reserved.
//

import UIKit

// MARK: - TrendingAlbumsViewController
class TrendingAlbumsViewController: UIViewController {
    
    var store: PhotoStore!
    @IBOutlet var collectionView: UICollectionView!
    var photosDatasource = PhotoDatasource()

    @objc private func reloadLayout() {
        self.collectionView.setNeedsLayout()
        self.collectionView.layoutIfNeeded()
    }
    
    private func reloadCollectionViewLayout() {
        let cellPadding: CGFloat = 4
        let cellsPerRow: CGFloat = 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding)
        let screenWidth = UIScreen.main.bounds.size.width - (cellPadding * 2)
        layout.itemSize = CGSize(width: screenWidth/cellsPerRow, height: screenWidth/cellsPerRow)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionView.collectionViewLayout = layout
    }
    
    private func setupLayout() {
        self.title = "Trending"
        self.collectionView.delegate = self
        self.collectionView.dragInteractionEnabled = true
        self.collectionView.dragDelegate = self
        self.collectionView.dropDelegate = self
        self.collectionView.dataSource = photosDatasource
        self.collectionView.backgroundColor = .systemBackground
        self.view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(self, selector: #selector(reloadLayout), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    // MARK: - View Lifecycle
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.store.fetchInterestingPhotos { result in
            switch result {
            case .success(let photos):
                photos.forEach { (photo) in
                    self.store.imageStore.image(forKey: "\(photo.albumID)")
                }
                self.photosDatasource.photos = photos
            case .failure(let error):
                print("ERROR: \(error)")
                self.photosDatasource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadCollectionViewLayout()
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
            self.reloadCollectionViewLayout()
    }
}

// MARK: - UICollectionViewDelegate
extension TrendingAlbumsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = self.photosDatasource.photos[indexPath.row]
            store.fetchImage(for: photo, downsampleTo: cell.bounds.size, scaleTo: collectionView.traitCollection.displayScale) { result in
            guard let photoIndex = self.photosDatasource.photos.firstIndex(of: photo),
                case let .success(image) = result else {
                    return
            }
            if let cell = self.collectionView.cellForItem(at: IndexPath(item: photoIndex, section: 0)) as? AlbumPhotoCell {
                cell.update(displaying: image)
            }
        }
    }
}

// MARK: - UICollectionViewDragDelegate, UICollectionViewDropDelegate
extension TrendingAlbumsViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates({
                self.photosDatasource.photos.remove(at: sourceIndexPath.item)
                self.photosDatasource.photos.insert(item.dragItem.localObject as! PrimaryRelease, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            }, completion: nil)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destIndexPath = IndexPath(item: row-1, section: 0)
        }
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destIndexPath, collectionView: collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.photosDatasource.photos[indexPath.row]
        let itemProvider = NSItemProvider(object: "\(item.albumID)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}
