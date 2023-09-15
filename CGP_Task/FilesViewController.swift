//
//  ViewController.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 12.09.2023.
//

import UIKit
import PDFKit
import UniformTypeIdentifiers

class FilesViewController: UIViewController,UISearchBarDelegate {
    
   private let searchBar = UISearchBar()
   private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
   private var activityIndicator = UIActivityIndicatorView()

    
    var pdfDocs = [PDFDocumentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        setUpUI()
    }
    
    private func setUpUI () {
        setupNavigationBarTitle()
        addRightBarButtonItems()
        setUpSearchBar()
        setupViews()
        setupRoundButton()
        setupConstraints()
        configureActivityIndicator()
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
    
    private func  setupNavigationBarTitle() {
        
        let titleLabel = UILabel()
        
        let attributedString = NSAttributedString(string: Constants.navBarTitle, attributes: [
            .font: UIFont.systemFont(ofSize: 26, weight: .bold),
            .foregroundColor: UIColor.black,
        ])
        
        titleLabel.attributedText = attributedString
        let titleBarItem = UIBarButtonItem(customView: titleLabel)
        
        self.navigationItem.setLeftBarButton(titleBarItem, animated: true)
    }
    
    private func addRightBarButtonItems() {
        
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .default)
        
        let buttonOne = UIButton(type: .custom)
        buttonOne.frame.size = CGSize(width: 36, height: 36)
        let imageBell = UIImage(systemName: "bell",withConfiguration: config)
        buttonOne.setImage(imageBell, for: .normal)
        buttonOne.tintColor = UIColor(named: "FirstColor")
        
        let buttonTwo = UIButton(type: .custom)
        let imageEllipsis = UIImage(systemName: "ellipsis", withConfiguration: config)
        buttonTwo.setImage(imageEllipsis, for: .normal)
        buttonTwo.tintColor = UIColor(named: "FirstColor")
        
        applyCommonStyles(to: buttonOne)
        applyCommonStyles(to: buttonTwo)
        
        let stackview = UIStackView(arrangedSubviews: [buttonOne, buttonTwo])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 15
        
        let rightBarButton = UIBarButtonItem(customView: stackview)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func applyCommonStyles(to button: UIButton) {
        button.backgroundColor = .clear
        button.widthAnchor.constraint(equalToConstant: 36).isActive = true
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
    }
    private func setUpSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = Constants.searchBarPlaceholder
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionView.cellIdentifier)
    }
    
    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -10),
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setUpConstraintsForButton(to button: UIButton) {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
    }
    
    func setupRoundButton() {
        let button = RoundButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                
                view.addSubview(button)
                setUpConstraintsForButton(to: button)
                
                button.addTarget(self, action: #selector(openPickerViewController), for: .touchUpInside)
    }
    
    @objc func openPickerViewController() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    private func addPDFtoArray(url: URL) {
        let pdfDocument = PDFDocumentModel(documentURL: url)
        
        activityIndicator.startAnimating()
    
        DispatchQueue.global().async {
            self.pdfDocs.append(pdfDocument)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
     func displayPDF(url: URL) {
        
        let pdfVC = PDFViewController()
        pdfVC.pdfURL = url
        navigationController?.pushViewController(pdfVC, animated: true)
    }
    
    @objc func editButtonTapped(sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            self.pdfDocs.remove(at: sender.tag)
            self.collectionView.reloadData()
            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func getPDFPreviewImage(url: URL) -> UIImage? {
        guard let pdfDocument = PDFDocument(url: url) else { return nil }
        
        guard let pdfPage = pdfDocument.page(at: 0) else { return nil }
        
        let pageRect = pdfPage.bounds(for: .mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(pdfPage.pageRef!)
        }
        
        return img
    }
    
}

// MARK: - UICollectionViewDelegate + UICollectionViewDataSource

extension FilesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pdfDocs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.cellIdentifier, for: indexPath) as! CollectionViewCell
        let document = pdfDocs[indexPath.row]
        let url = document.documentURL
        let documentName = document.documentName
        
        
        if let image = getPDFPreviewImage(url: url) {
            // Do something with the image
            cell.imageView.image = image
        } else {
            print(Constants.AlertMessages.failedToGetPreviewImage)
        }
        
        if let fileAttributesText = document.fileAttributes {
            cell.dateLabel.text = fileAttributesText
        } else {
            print(Constants.AlertMessages.failedToGetFileAttributes)
        }
        
        cell.nameLabel.text = documentName
        let imageEllipsis = UIImage(systemName: Constants.ImageNames.ellipsisRectangleFill)
        cell.button.setImage(imageEllipsis, for: .normal)
        cell.button.addTarget(self, action: #selector(editButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension FilesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = pdfDocs[indexPath.row].documentURL
        
        displayPDF(url: url)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension FilesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 116, height: 202)
    }
    
}
// MARK: - UIDocumentPickerDelegate
extension FilesViewController:UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        addPDFtoArray(url: url)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}

