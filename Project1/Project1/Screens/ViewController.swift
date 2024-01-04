//
//  ViewController.swift
//  Project1
//
//  Created by gayeugur on 25.11.2023.
//

import UIKit

class ViewController: UIViewController {
   
    //MARK: @IBOUTLET
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: PROPERTIES
    var pictures = [String]()

    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pictures"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PictureCell", bundle: nil), forCellReuseIdentifier: "pictureCell")
        getData()
    }

    //MARK: FUNCTIONS
    func getData() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }

}

//MARK: UITABLEVIEWDELEGATE
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let vc = DetailVC()
        vc.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UITABLEVIEWDATASOURCE
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath) as? PictureCell else {
            return UITableViewCell()
        }
        cell.pictureLabel.text = pictures[indexPath.row]
        return cell
    }
    
    
}
