import SlideController
import UIKit

class TestTitleScrollView: TitleScrollView<TestTitleItem> {
    private var internalItems: [View] = []
    private let internalItemOffsetX: CGFloat = 15
    private let itemOffsetTop: CGFloat = 36
    private let itemHeight: CGFloat = 36
    private let shadowOpacity: Float = 0.16
    private let internalBackgroundColor = UIColor.purple

    required override init() {
        super.init()
        clipsToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = shadowOpacity
        backgroundColor = internalBackgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var items: [TitleItem] {
        internalItems
    }

    override func appendViews(views: [View]) {
        var prevView: View? = internalItems.last
        let prevPrevView: UIView? = internalItems.count > 1 ? internalItems[items.count - 2] : nil
        if let prevItem = prevView {
            updateConstraints(prevItem, prevView: prevPrevView, isLast: false)
        }
        for i in 0...views.count - 1 {
            let view = views[i]
            view.translatesAutoresizingMaskIntoConstraints = false
            internalItems.append(view)
            addSubview(view)
            activateConstraints(view, prevView: prevView, isLast: i == views.count - 1)
            prevView = view
        }
    }

    override func insertView(view: View, index: Int) {
        guard index < internalItems.count else {
            return
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        internalItems.insert(view, at: index)
        addSubview(view)
        let prevView: View? = index > 0 ? internalItems[index - 1] : nil
        let nextView: View = internalItems[index + 1]
        activateConstraints(view, prevView: prevView, isLast: false)
        updateConstraints(nextView, prevView: view, isLast: index == internalItems.count - 2)
    }

    override func removeViewAtIndex(index: Int) {
        guard index < internalItems.count else {
            return
        }
        let view: View = internalItems[index]
        let prevView: View? = index > 0 ? internalItems[index - 1] : nil
        let nextView: View? = index < internalItems.count - 1 ? internalItems[index + 1] : nil
        internalItems.remove(at: index)
        view.removeFromSuperview()
        if let nextView = nextView {
            updateConstraints(nextView, prevView: prevView, isLast: index == internalItems.count - 1)
        } else if let prevView = prevView {
            let prevPrevView: View? = internalItems.count > 1 ? internalItems[internalItems.count - 2] : nil
            updateConstraints(prevView, prevView: prevPrevView, isLast: true)
        }
    }

    var isTransparent = false {
        didSet {
            backgroundColor = isTransparent ? UIColor.clear : internalBackgroundColor
        }
    }
}

private typealias PrivateTestTitleScrollView = TestTitleScrollView
private extension PrivateTestTitleScrollView {
    func activateConstraints(_ view: UIView, prevView: UIView?, isLast: Bool) {
        var constraints: [NSLayoutConstraint] = []
        constraints.append(view.topAnchor.constraint(equalTo: topAnchor, constant: itemOffsetTop))
        constraints.append(view.heightAnchor.constraint(equalToConstant: itemHeight))
        if let prevView = prevView {
            constraints.append(view.leadingAnchor.constraint(equalTo: prevView.trailingAnchor, constant: 2 * itemOffsetX()))
        } else {
            constraints.append(view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: itemOffsetX()))
        }
        if isLast {
            constraints.append(view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -itemOffsetX()))
        }
        NSLayoutConstraint.activate(constraints)
    }

    func removeConstraints(view: UIView) {
        let viewConstraints = constraints.filter { $0.firstItem === view }
        let heigthConstraints = view.constraints.filter { $0.firstAttribute == .height }
        NSLayoutConstraint.deactivate(viewConstraints + heigthConstraints)
    }

    func updateConstraints(_ view: UIView, prevView: UIView?, isLast: Bool) {
        removeConstraints(view: view)
        activateConstraints(view, prevView: prevView, isLast: isLast)
    }

    func itemOffsetX() -> CGFloat {
        internalItemOffsetX
    }
}
