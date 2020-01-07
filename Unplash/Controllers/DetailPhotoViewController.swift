import UIKit
import Kingfisher

class DetailPhotoViewController: UIViewController {
  
  var photo: Photo!
  
  var background: UIColor!
  
  var imageURL: String! {
    didSet {
      imageView.kf.indicatorType = .activity
      imageView.kf.setImage(with: URL(string: imageURL))
    }
  }
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let infoBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.alpha = 0.7
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let infoView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .fill
    stackView.axis = .vertical
    stackView.backgroundColor = .white
    return stackView
  }()
  
  private let toolBar: UIToolbar = {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 400, height: 44))
    var items = [UIBarButtonItem]()
    items.append(
      UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveImageButtonTapped))
    )
    
    items.append(
      UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    )
    
    items.append(
      UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareLinkButtonTapped))
    )
    toolbar.setItems(items, animated: true)
    toolbar.tintColor = .red
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    return toolbar
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupLabels()
    self.view.addSubview(imageView)
    self.view.addSubview(toolBar)
    self.view.addSubview(infoView)
    
    toolBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    toolBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true

    infoView.bottomAnchor.constraint(equalTo: toolBar.topAnchor, constant: 0).isActive = true
    infoView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
    infoView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
    
    imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
    imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
    imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
  }
  
  @objc func saveImageButtonTapped() {
    guard let image = imageView.image else { return }
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      showAlertError(error.localizedDescription)
    } else {
      showAlert("Изображение успешно сохранено в галерее")
    }
  }

  @objc func shareLinkButtonTapped() {
    let activityController = UIActivityViewController(activityItems: [photo.urls[URLKind.full.rawValue] ?? ""], applicationActivities: nil)
    present(activityController, animated: true, completion: nil)
  }
  
  private func setupLabels() {
    let dimensionsLabel = UILabel()
    dimensionsLabel.textAlignment = .center
    dimensionsLabel.numberOfLines = 0
    dimensionsLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6970515839)
    dimensionsLabel.text = "Разрешение: \(photo.height) X \(photo.width)"
    
    let descLabel = UILabel()
    descLabel.textAlignment = .center
    descLabel.numberOfLines = 0
    descLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6970515839)
    descLabel.text = "Описание: " + (photo.description ?? "отсутствует")
    
    infoView.addArrangedSubview(dimensionsLabel)
    infoView.addArrangedSubview(descLabel)
  }
  
  private func setupView() {
    let tap = UITapGestureRecognizer(target: self, action: Selector(("viewTapped")))
    view.addGestureRecognizer(tap)
    self.view.backgroundColor = background
  }
  
  @objc func viewTapped() {
    self.dismiss(animated: true, completion: nil)
  }
}
