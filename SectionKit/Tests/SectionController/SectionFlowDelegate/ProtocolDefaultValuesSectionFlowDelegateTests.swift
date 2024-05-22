import SectionKit
import XCTest

final class ProtocolDefaultValuesSectionFlowDelegateTests: BaseFlowLayoutSectionFlowDelegateTests {
    @MainActor
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        class DefaultSectionFlowDelegate: SectionFlowDelegate { }
        return DefaultSectionFlowDelegate()
    }
}
