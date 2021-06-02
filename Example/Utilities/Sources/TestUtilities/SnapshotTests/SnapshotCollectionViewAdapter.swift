import SectionKit

open class SnapshotCollectionViewAdapter: SingleSectionCollectionViewAdapter {
    override open func calculateUpdate(
        from oldData: Section?,
        to newData: Section?
    ) -> CollectionViewUpdate<Section?>? {
        CollectionViewUpdate(data: newData, setData: { [self] in collectionViewSection = $0 })
    }
}
