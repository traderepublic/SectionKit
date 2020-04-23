import UIKit
import SectionKit
import DiffingSectionKit
import ReactiveCocoa
import ReactiveSwift

class PortfolioViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: PortfolioViewModelType

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    private var sectionAdapter: SectionAdapter?
    private let portfolioSection = ChartSectionController()
    private lazy var stockSection = StockSectionController(viewModel: viewModel.outputs.stockSection)
    private lazy var watchlistSection = StockSectionController(viewModel: viewModel.outputs.watchlistSection)

    // MARK: - Initialization
    init(viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()

        let sectionControllers: [SectionController] = [portfolioSection, stockSection, watchlistSection]
        sectionAdapter = DiffingSectionAdapter(viewController: self,
                                               collectionView: collectionView,
                                               sectionControllers: sectionControllers)
    }

    private func setUpBindings() {
        portfolioSection.reactive.viewModel <~ viewModel.outputs.portfolioHeaderSection
        viewModel.outputs.stockSection.inputs.mutableStocks <~ stockSection.itemsMoved
        viewModel.outputs.watchlistSection.inputs.mutableStocks <~ watchlistSection.itemsMoved
    }
}
