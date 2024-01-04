//
//  DetailVC.swift
//  Project1
//
//  Created by gayeugur on 25.11.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    //MARK: @IBOUTLET
    @IBOutlet weak var detailImageView: UIImageView!
    
    //MARK: PROPERTIES
    var selectedImage: String?
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedImage
        initNavBar()
        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    //MARK: FUNCTIONS
    
    private func initNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    private func loadImage() {
        if let imageToLoad = selectedImage {
            detailImageView.image  = UIImage(named: imageToLoad)
        }
    }
    
    @objc func shareTapped() {
        guard let image = detailImageView.image?.jpegData(compressionQuality: 0.8) else {
              print("No image found")
              return
          }

          let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
          vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
          present(vc, animated: true)
    }


}
