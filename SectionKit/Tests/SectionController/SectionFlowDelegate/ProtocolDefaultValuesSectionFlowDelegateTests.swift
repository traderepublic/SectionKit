import SectionKit
import XCTest

@MainActor
internal final class ProtocolDefaultValuesSectionFlowDelegateTests: BaseSectionFlowDelegateTests {
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        class DefaultSectionFlowDelegate: SectionFlowDelegate { }
        return DefaultSectionFlowDelegate()
    }
}
