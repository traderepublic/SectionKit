import SectionKit
import XCTest

@MainActor
internal final class ProtocolDefaultValuesSectionDelegateTests: BaseSectionDelegateTests {
    override func createSectionDelegate() throws -> SectionDelegate {
        class DefaultSectionDelegate: SectionDelegate { }
        return DefaultSectionDelegate()
    }
}
