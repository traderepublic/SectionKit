import UIKit

extension SingleSectionCollectionViewAdapter {
    @inlinable
    public func controller(at indexPath: IndexPath) -> SectionController? {
        guard indexPath.isValid else {
            return nil
        }
        return controller(at: indexPath.section)
    }

    @inlinable
    public func controller(at index: Int) -> SectionController? {
        guard index == 0 else {
            return nil
        }
        return section?.controller
    }
}

extension SingleSectionCollectionViewAdapter {
    @inlinable
    public func dataSource(at indexPath: IndexPath) -> SectionDataSource? {
        controller(at: indexPath)?.dataSource
    }

    @inlinable
    public func dataSource(at index: Int) -> SectionDataSource? {
        controller(at: index)?.dataSource
    }
}

@available(iOS 10.0, *)
extension SingleSectionCollectionViewAdapter {
    @inlinable
    public func dataSourcePrefetchingDelegate(at indexPath: IndexPath) -> SectionDataSourcePrefetchingDelegate? {
        controller(at: indexPath)?.dataSourcePrefetchingDelegate
    }

    @inlinable
    public func dataSourcePrefetchingDelegate(at index: Int) -> SectionDataSourcePrefetchingDelegate? {
        controller(at: index)?.dataSourcePrefetchingDelegate
    }
}

extension SingleSectionCollectionViewAdapter {
    @inlinable
    public func delegate(at indexPath: IndexPath) -> SectionDelegate? {
        controller(at: indexPath)?.delegate
    }

    @inlinable
    public func delegate(at index: Int) -> SectionDelegate? {
        controller(at: index)?.delegate
    }
}

extension SingleSectionCollectionViewAdapter {
    @inlinable
    public func flowDelegate(at indexPath: IndexPath) -> SectionFlowDelegate? {
        if #available(iOS 13.0, *) {
            return controller(at: indexPath)?.layoutProvider.flowLayoutProvider
        } else {
            return controller(at: indexPath)?.flowDelegate
        }
    }

    @inlinable
    public func flowDelegate(at index: Int) -> SectionFlowDelegate? {
        if #available(iOS 13.0, *) {
            return controller(at: index)?.layoutProvider.flowLayoutProvider
        } else {
            return controller(at: index)?.flowDelegate
        }
    }
}

@available(iOS 11.0, *)
extension SingleSectionCollectionViewAdapter {
    @inlinable
    public func dragDelegate(at indexPath: IndexPath) -> SectionDragDelegate? {
        controller(at: indexPath)?.dragDelegate
    }

    @inlinable
    public func dragDelegate(at index: Int) -> SectionDragDelegate? {
        controller(at: index)?.dragDelegate
    }
}

@available(iOS 11.0, *)
extension SingleSectionCollectionViewAdapter {
    @inlinable
    public func dropDelegate(at indexPath: IndexPath) -> SectionDropDelegate? {
        controller(at: indexPath)?.dropDelegate
    }

    @inlinable
    public func dropDelegate(at index: Int) -> SectionDropDelegate? {
        controller(at: index)?.dropDelegate
    }
}
