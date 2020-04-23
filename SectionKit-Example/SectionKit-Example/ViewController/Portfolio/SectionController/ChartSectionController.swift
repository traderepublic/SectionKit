import SectionKit
import DifferenceKit
import ReactiveSwift
import UIKit

// MARK: - SectionController

class ChartSectionController: SectionController {
    var context: CollectionContext?

    let id: UUID = UUID()

    private var collectionViewItem: ChartCellViewModel?
    var viewModel: ChartCellViewModel? {
        get { collectionViewItem }
        set {
            guard let context = context else {
                collectionViewItem = newValue
                return
            }
            context.apply(update: SectionUpdate(sectionId: id,
                                                data: newValue,
                                                setData: { [weak self] in self?.collectionViewItem = $0 }))
        }
    }

    var dataSource: SectionDataSource { self }

    var delegate: SectionDelegate? { self }

    var flowDelegate: SectionFlowDelegate? { self }
}

// MARK: - SectionDataSource

extension ChartSectionController: SectionDataSource {
    var numberOfItems: Int {
        viewModel == nil ? 0 : 1
    }

    func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell  {
        guard
            let cell = context?.dequeueReusableCell(PortfolioHeaderCell.self,
                                                    for: indexPath.externalRepresentation)
            else {
                assertionFailure("Could not dequeue `PortfolioCell`.")
                return UICollectionViewCell()
        }
        guard let viewModel = viewModel else {
            assertionFailure("Did not set `viewModel` before calling \(#function)")
            return cell
        }
        cell.configure(with: viewModel)
        return cell
    }
}

// MARK: - SectionDelegate

extension ChartSectionController: SectionDelegate {
    func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool {
        false
    }

    func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool {
        false
    }
}

// MARK: - SectionFlowDelegate

extension ChartSectionController: SectionFlowDelegate {
    func sizeForItem(at indexPath: SectionIndexPath,
                     using layout: UICollectionViewLayout) -> CGSize {
        guard let viewModel = viewModel else {
            preconditionFailure("Did not set `viewModel` before calling \(#function)")
        }
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        let width = context.insetContainerSize.width
        let height = CGFloat.greatestFiniteMagnitude
        let maxSize = CGSize(width: width, height: height)
        return PortfolioHeaderCell.size(for: viewModel, size: maxSize)
    }

    func inset(using layout: UICollectionViewLayout,
               in collectionView: UICollectionView) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
    }
}

// MARK: - Reactive extensions

extension ChartSectionController: ReactiveExtensionsProvider { }

extension Reactive where Base: ChartSectionController {
    var viewModel: BindingTarget<ChartCellViewModel> {
        makeBindingTarget { base, viewModel in
            base.viewModel = viewModel
        }
    }
}
