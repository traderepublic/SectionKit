import SectionKit
import XCTest

final class ProtocolDefaultValuesSectionFlowDelegateTests: BaseSectionFlowDelegateTests {
    @MainActor
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        class DefaultSectionFlowDelegate: SectionFlowDelegate { }
        return DefaultSectionFlowDelegate()
    }
}
