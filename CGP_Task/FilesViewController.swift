//
//  ViewController.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 12.09.2023.
//

import UIKit
import PDFKit

class FilesViewController: UIViewController,UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var pdfDocs = [PDFDocument]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupNavigationBarTitle()
        addRightBarButtonItems()
        setUpSearchBar()
        setupViews()
        setupConstraints()
        setupRoundButton()
    }
    
    
    private func setUpSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search documents"
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    private func  setupNavigationBarTitle() {
        
        let titleLabel = UILabel()
        
        let attributedString = NSAttributedString(string: "My Files", attributes: [
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
        button.contentEdgeInsets = UIEdgeInsets(top: button.contentEdgeInsets.top + 5, left: button.contentEdgeInsets.left + 5, bottom: button.contentEdgeInsets.bottom + 5, right: button.contentEdgeInsets.right + 5)
        button.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
    
    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -10),
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
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
    
    func setupRoundButton() {
        let button = UIButton(type: .system)
        
        let mainColor = UIColor(named: "FirstColor") ?? UIColor.blue
        let lighterColor = mainColor.withAlphaComponent(0.85).cgColor
        
        
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        button.frame.size = CGSize(width: 60, height: 60)
        button.layer.cornerRadius = 30
        view.addSubview(button)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [lighterColor, mainColor.cgColor, lighterColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        
        gradientLayer.frame = button.bounds
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    
    @objc func didTapButton() {
        
        let pdfType = "com.adobe.pdf"
        let documentPicker = UIDocumentPickerViewController(documentTypes: [pdfType], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
}

extension FilesViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        // In this function is the code you must implement to your code project if you want to change size of Collection view
        return CGSize(width: 116, height: 202)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pdfDocs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CollectionViewCell
        let url = pdfDocs[indexPath.row].documentURL
        let documentName = url?.lastPathComponent

        
        if let image = getPDFPreviewImage(url: url!) {
            // Do something with the image
            cell.imageView.image = image
        } else {
            print("Failed to obtain preview image")
        }
        
        cell.backgroundColor = .lightGray
        cell.nameLabel.text = documentName
        cell.dateLabel.text = "01.02.2021 • 1171 KB"
        let imageEllipsis = UIImage(systemName: "ellipsis.rectangle.fill")
        cell.button.setImage(imageEllipsis, for: .normal)
        cell.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = pdfDocs[indexPath.row].documentURL else {
            return
        }
        
        displayPDF(url: url)
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

extension FilesViewController:UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        savePDF(url: url)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func savePDF(url: URL) {
        guard let pdfDocument = PDFDocument(url: url) else {
            print("Failed to load the PDF document.")
            return
        }
        
        pdfDocs.append(pdfDocument)
        collectionView.reloadData()
    }
    
    private func displayPDF(url: URL) {
        
        let pdfVC = PDFViewController()
        pdfVC.pdfURL = url
        navigationController?.pushViewController(pdfVC, animated: true)
    }
    
    
}

