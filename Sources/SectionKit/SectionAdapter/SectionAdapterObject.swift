import Foundation

public enum SectionAdapterObject {
    case section(id: AnyHashable, model: AnyHashable)
    case dataSource(SectionAdapterDataSource)
}
