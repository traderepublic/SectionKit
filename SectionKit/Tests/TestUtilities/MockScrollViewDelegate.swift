import UIKit
import XCTest

internal class MockScrollViewDelegate: NSObject, UIScrollViewDelegate {
    // MARK: - scrollViewDidScroll

    internal typealias ScrollViewDidScrollBlock = (UIScrollView) -> Void

    internal var _scrollViewDidScroll: ScrollViewDidScrollBlock = { _ in
        XCTFail("not implemented")
    }

    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _scrollViewDidScroll(scrollView)
    }

    // MARK: - scrollViewDidZoom

    internal typealias ScrollViewDidZoomBlock = (UIScrollView) -> Void

    internal var _scrollViewDidZoom: ScrollViewDidZoomBlock = { _ in
        XCTFail("not implemented")
    }

    internal func scrollViewDidZoom(_ scrollView: UIScrollView) {
        _scrollViewDidZoom(scrollView)
    }

    // MARK: - scrollViewWillBeginDragging

    internal typealias ScrollViewWillBeginDraggingBlock = (UIScrollView) -> Void

    internal var _scrollViewWillBeginDragging: ScrollViewWillBeginDraggingBlock = { _ in
        XCTFail("not implemented")
    }

    internal func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _scrollViewWillBeginDragging(scrollView)
    }

    // MARK: - scrollViewWillEndDragging

    internal typealias ScrollViewWillEndDraggingBlock = (UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void

    internal var _scrollViewWillEndDragging: ScrollViewWillEndDraggingBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        _scrollViewWillEndDragging(scrollView, velocity, targetContentOffset)
    }

    // MARK: - scrollViewDidEndDragging

    internal typealias ScrollViewDidEndDraggingBlock = (UIScrollView, Bool) -> Void

    internal var _scrollViewDidEndDragging: ScrollViewDidEndDraggingBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _scrollViewDidEndDragging(scrollView, decelerate)
    }

    // MARK: - scrollViewWillBeginDecelerating

    internal typealias ScrollViewWillBeginDeceleratingBlock = (UIScrollView) -> Void

    internal var _scrollViewWillBeginDecelerating: ScrollViewWillBeginDeceleratingBlock = { _ in
        XCTFail("not implemented")
    }

    internal func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        _scrollViewWillBeginDecelerating(scrollView)
    }

    // MARK: - scrollViewDidEndDecelerating

    internal typealias ScrollViewDidEndDeceleratingBlock = (UIScrollView) -> Void

    internal var _scrollViewDidEndDecelerating: ScrollViewDidEndDeceleratingBlock = { _ in
        XCTFail("not implemented")
    }

    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        _scrollViewDidEndDecelerating(scrollView)
    }

    // MARK: - scrollViewDidEndScrollingAnimation

    internal typealias ScrollViewDidEndScrollingAnimationBlock = (UIScrollView) -> Void

    internal var _scrollViewDidEndScrollingAnimation: ScrollViewDidEndScrollingAnimationBlock = { _ in
        XCTFail("not implemented")
    }

    internal func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        _scrollViewDidEndScrollingAnimation(scrollView)
    }

    // MARK: - viewForZooming

    internal typealias ViewForZoomingBlock = (UIScrollView) -> UIView?

    internal var _viewForZooming: ViewForZoomingBlock = { _ in
        XCTFail("not implemented")
        return nil
    }

    internal func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        _viewForZooming(scrollView)
    }

    // MARK: - scrollViewWillBeginZooming

    internal typealias ScrollViewWillBeginZoomingBlock = (UIScrollView, UIView?) -> Void

    internal var _scrollViewWillBeginZooming: ScrollViewWillBeginZoomingBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        _scrollViewWillBeginZooming(scrollView, view)
    }

    // MARK: - scrollViewDidEndZooming

    internal typealias ScrollViewDidEndZoomingBlock = (UIScrollView, UIView?, CGFloat) -> Void

    internal var _scrollViewDidEndZooming: ScrollViewDidEndZoomingBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func scrollViewDidEndZooming(
        _ scrollView: UIScrollView,
        with view: UIView?,
        atScale scale: CGFloat
    ) {
        _scrollViewDidEndZooming(scrollView, view, scale)
    }

    // MARK: - scrollViewShouldScrollToTop

    internal typealias ScrollViewShouldScrollToTopBlock = (UIScrollView) -> Bool

    internal var _scrollViewShouldScrollToTop: ScrollViewShouldScrollToTopBlock = { _ in
        XCTFail("not implemented")
        return false
    }

    internal func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        _scrollViewShouldScrollToTop(scrollView)
    }

    // MARK: - scrollViewDidScrollToTop

    internal typealias ScrollViewDidScrollToTopBlock = (UIScrollView) -> Void

    internal var _scrollViewDidScrollToTop: ScrollViewDidScrollToTopBlock = { _ in
        XCTFail("not implemented")
    }

    internal func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        _scrollViewDidScrollToTop(scrollView)
    }

    // MARK: - scrollViewDidChangeAdjustedContentInset

    internal typealias scrollViewDidChangeAdjustedContentInsetBlock = (UIScrollView) -> Void

    internal var _scrollViewDidChangeAdjustedContentInset: scrollViewDidChangeAdjustedContentInsetBlock = { _ in
        XCTFail("not implemented")
    }

    internal func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        _scrollViewDidChangeAdjustedContentInset(scrollView)
    }
}
