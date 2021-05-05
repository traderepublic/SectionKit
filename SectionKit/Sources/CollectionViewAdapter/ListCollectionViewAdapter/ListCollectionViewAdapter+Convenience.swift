import UIKit

extension ListCollectionViewAdapter {
    @inlinable
    open func controller(at indexPath: IndexPath) -> SectionController? {
        guard indexPath.isValid else {
            return nil
        }
        return controller(at: indexPath.section)
    }

    @inlinable
    open func controller(at index: Int) -> SectionController? {
        guard index >= 0 && index < sections.count else {
            return nil
        }
        return sections[index].controller
    }
}

extension ListCollectionViewAdapter {
    @inlinable
    open func dataSource(at indexPath: IndexPath) -> SectionDataSource? {
        controller(at: indexPath)?.dataSource
    }

    @inlinable
    open func dataSource(at index: Int) -> SectionDataSource? {
        controller(at: index)?.dataSource
    }
}

@available(iOS 10.0, *)
extension ListCollectionViewAdapter {
    @inlinable
    open func dataSourcePrefetchingDelegate(at indexPath: IndexPath) -> SectionDataSourcePrefetchingDelegate? {
        controller(at: indexPath)?.dataSourcePrefetchingDelegate
    }

    @inlinable
    open func dataSourcePrefetchingDelegate(at index: Int) -> SectionDataSourcePrefetchingDelegate? {
        controller(at: index)?.dataSourcePrefetchingDelegate
    }
}

extension ListCollectionViewAdapter {
    @inlinable
    open func delegate(at indexPath: IndexPath) -> SectionDelegate? {
        controller(at: indexPath)?.delegate
    }

    @inlinable
    open func delegate(at index: Int) -> SectionDelegate? {
        controller(at: index)?.delegate
    }
}

extension ListCollectionViewAdapter {
    @inlinable
    open func flowDelegate(at indexPath: IndexPath) -> SectionFlowDelegate? {
        controller(at: indexPath)?.flowDelegate
    }

    @inlinable
    open func flowDelegate(at index: Int) -> SectionFlowDelegate? {
        controller(at: index)?.flowDelegate
    }
}

@available(iOS 11.0, *)
extension ListCollectionViewAdapter {
    @inlinable
    open func dragDelegate(at indexPath: IndexPath) -> SectionDragDelegate? {
        controller(at: indexPath)?.dragDelegate
    }

    @inlinable
    open func dragDelegate(at index: Int) -> SectionDragDelegate? {
        controller(at: index)?.dragDelegate
    }
}

@available(iOS 11.0, *)
extension ListCollectionViewAdapter {
    @inlinable
    open func dropDelegate(at indexPath: IndexPath) -> SectionDropDelegate? {
        controller(at: indexPath)?.dropDelegate
    }

    @inlinable
    open func dropDelegate(at index: Int) -> SectionDropDelegate? {
        controller(at: index)?.dropDelegate
    }
}
