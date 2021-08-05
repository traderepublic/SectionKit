import SectionKit
import XCTest

internal final class ProtocolDefaultValuesSectionFlowDelegateTests: BaseSectionFlowDelegateTests {
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        class DefaultSectionFlowDelegate: SectionFlowDelegate { }
        return DefaultSectionFlowDelegate()
    }
}
