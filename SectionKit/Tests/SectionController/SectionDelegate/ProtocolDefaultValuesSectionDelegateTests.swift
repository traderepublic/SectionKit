import SectionKit
import XCTest

final class ProtocolDefaultValuesSectionDelegateTests: BaseSectionDelegateTests {
    @MainActor
    override func createSectionDelegate() throws -> SectionDelegate {
        class DefaultSectionDelegate: SectionDelegate { }
        return DefaultSectionDelegate()
    }
}
