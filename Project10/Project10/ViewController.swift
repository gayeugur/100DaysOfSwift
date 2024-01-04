//
//  ViewController.swift
//  Project10
//
//  Created by gayeugur on 16.12.2023.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - PROPERTIES
    var people = [Person]()

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
      
    }
    
    // MARK: - FUNCTIONS
    private func initNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }

    // MARK: - OBJCECTIVE FUNCTIONS
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        
      /*  if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
        }*/
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    // MARK: - FUNCTIONS
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView?.reloadData()

        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // MARK: - OVERRIDE FUNCTIONS
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell

        let person = people[indexPath.item]

        cell.name.text = person.name

        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)

        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let firstAlert = UIAlertController(title: "Rename or Remove", message: nil, preferredStyle: .alert)
        firstAlert.addAction(UIAlertAction(title: "Rename", style: .default) {_ in
            
            let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            ac.addTextField()

            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

            ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
                let newName = ac.textFields![0]
                person.name = newName.text!

                self.collectionView?.reloadData()
            })

            self.present(ac, animated: true)
        })
        firstAlert.addAction(UIAlertAction(title: "Remove", style: .default) { _ in
            self.people.remove(at: indexPath.item)
            collectionView.reloadData()
        })
        present(firstAlert, animated: true)
       
    }


}

