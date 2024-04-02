import SectionKit
import XCTest

@MainActor
internal final class ProtocolDefaultValuesSectionFlowDelegateTests: BaseFlowLayoutSectionFlowDelegateTests {
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        class DefaultSectionFlowDelegate: SectionFlowDelegate { }
        return DefaultSectionFlowDelegate()
    }
}
