import UIKit

extension SingleSectionCollectionViewAdapter {
    open func controller(at indexPath: IndexPath) -> SectionController? {
        guard indexPath.isValid else {
            return nil
        }
        guard let controller = controller(at: indexPath.section) else {
            return nil
        }
        return controller
    }

    open func controller(at index: Int) -> SectionController? {
        guard index == 0 else {
            return nil
        }
        guard let controller = section?.controller else {
            return nil
        }
        return controller
    }
}

extension SingleSectionCollectionViewAdapter {
    open func dataSource(at indexPath: IndexPath) -> SectionDataSource? {
        guard let controller = controller(at: indexPath) else {
            return nil
        }
        return controller.dataSource
    }

    open func dataSource(at index: Int) -> SectionDataSource? {
        guard let controller = controller(at: index) else {
            return nil
        }
        return controller.dataSource
    }
}

@available(iOS 10.0, *)
extension SingleSectionCollectionViewAdapter {
    open func dataSourcePrefetchingDelegate(at indexPath: IndexPath) -> SectionDataSourcePrefetchingDelegate? {
        guard let controller = controller(at: indexPath) else {
            return nil
        }
        guard let dataSourcePrefetchingDelegate = controller.dataSourcePrefetchingDelegate else {
            return nil
        }
        return dataSourcePrefetchingDelegate
    }

    open func dataSourcePrefetchingDelegate(at index: Int) -> SectionDataSourcePrefetchingDelegate? {
        guard let controller = controller(at: index) else {
            return nil
        }
        guard let dataSourcePrefetchingDelegate = controller.dataSourcePrefetchingDelegate else {
            return nil
        }
        return dataSourcePrefetchingDelegate
    }
}

extension SingleSectionCollectionViewAdapter {
    open func delegate(at indexPath: IndexPath) -> SectionDelegate? {
        guard let controller = controller(at: indexPath) else {
            return nil
        }
        guard let delegate = controller.delegate else {
            return nil
        }
        return delegate
    }

    open func delegate(at index: Int) -> SectionDelegate? {
        guard let controller = controller(at: index) else {
            return nil
        }
        guard let delegate = controller.delegate else {
            return nil
        }
        return delegate
    }
}

extension SingleSectionCollectionViewAdapter {
    open func flowDelegate(at indexPath: IndexPath) -> SectionFlowDelegate? {
        guard let controller = controller(at: indexPath) else {
            return nil
        }
        guard let flowDelegate = controller.flowDelegate else {
            return nil
        }
        return flowDelegate
    }

    open func flowDelegate(at index: Int) -> SectionFlowDelegate? {
        guard let controller = controller(at: index) else {
            return nil
        }
        guard let flowDelegate = controller.flowDelegate else {
            return nil
        }
        return flowDelegate
    }
}

@available(iOS 11.0, *)
extension SingleSectionCollectionViewAdapter {
    open func dragDelegate(at indexPath: IndexPath) -> SectionDragDelegate? {
        guard let controller = controller(at: indexPath) else {
            return nil
        }
        guard let dragDelegate = controller.dragDelegate else {
            return nil
        }
        return dragDelegate
    }

    open func dragDelegate(at index: Int) -> SectionDragDelegate? {
        guard let controller = controller(at: index) else {
            return nil
        }
        guard let dragDelegate = controller.dragDelegate else {
            return nil
        }
        return dragDelegate
    }
}

@available(iOS 11.0, *)
extension SingleSectionCollectionViewAdapter {
    open func dropDelegate(at indexPath: IndexPath) -> SectionDropDelegate? {
        guard let controller = controller(at: indexPath) else {
            return nil
        }
        guard let dropDelegate = controller.dropDelegate else {
            return nil
        }
        return dropDelegate
    }

    open func dropDelegate(at index: Int) -> SectionDropDelegate? {
        guard let controller = controller(at: index) else {
            return nil
        }
        guard let dropDelegate = controller.dropDelegate else {
            return nil
        }
        return dropDelegate
    }
}
