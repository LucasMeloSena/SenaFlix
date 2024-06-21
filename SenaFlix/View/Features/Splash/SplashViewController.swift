import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    //MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: K.appColors.black600)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.images.globoplayLogo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - ACTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        loadUI()
        loadConstraints()
        callHomeScreen()
    }
    
    private func loadUI() {
        view.addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    private func loadConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func callHomeScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            let homeVC = HomeViewController()
            self?.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
}
