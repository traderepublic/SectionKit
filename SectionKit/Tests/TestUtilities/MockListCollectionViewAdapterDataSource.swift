import SectionKit

internal class MockListCollectionViewAdapterDataSource: ListCollectionViewAdapterDataSource {
    internal var _sections: (CollectionViewAdapter) -> [Section]

    internal init(sections: @escaping (CollectionViewAdapter) -> [Section]) {
        _sections = sections
    }

    internal func sections(for adapter: CollectionViewAdapter) -> [Section] {
        _sections(adapter)
    }
}
