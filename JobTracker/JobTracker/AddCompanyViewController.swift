//
//  AddCompanyViewController.swift
//  JobTracker
//
//  Created by 酒井綾菜 on 2019-05-14.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import CoreData

// protocol (passing data back to companyTableViewController)
protocol AddCompanyControllerDelegate: class {
    func addCompanyDidFfinish(company: Company)
    func editCompanyDidFinish(company: Company)
}

class AddCompanyViewController: UIViewController {
    
    weak var delegate: AddCompanyControllerDelegate?
    
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            guard let applied = company?.applied else { return }
            datePicker.date = applied
        }
    }
    
    lazy var companyImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 100
        iv.backgroundColor = .white
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.spaceGray.cgColor
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Company"
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return lb
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.backgroundColor = .white
        dp.datePickerMode = .date
        dp.layer.cornerRadius = 16
        dp.layer.borderWidth = 5
        dp.layer.borderColor = UIColor.spaceGray.cgColor
        dp.layer.masksToBounds = true
        return dp
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your company..."
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.layer.borderWidth = 5
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigation()
        setupUI()
    }
    
    // MARK: helper functions
    
    private func setupUI() {
        view.addSubview(companyImageView)
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let hStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hStackView)
        
        hStackView.distribution = .fillProportionally
        hStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        hStackView.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 32).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        hStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 16).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true

    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = company == nil ? "Add Company " : "Edit Company"


        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        cancelBtn.tintColor = .white
        navigationItem.leftBarButtonItem = cancelBtn
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        saveBtn.tintColor = .white
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    
    @objc func selectImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func cancelPressed() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func savePressed() {
        
        // save
        if company == nil {
            // add (create)
            // NSManagedObjectContext: scratch pad
            // - viewContext: ManagedObjectContext (main thread)
            let managedContext = CoreDataManager.shared.persistentContainer.viewContext
            let newCompany = NSEntityDescription.insertNewObject(forEntityName: "Company", into: managedContext)
            newCompany.setValue(nameTextField.text ?? "", forKey: "name")
            newCompany.setValue(datePicker.date, forKey: "applied")
            if let newCompanyImage = companyImageView.image {
                let imageData = newCompanyImage.jpegData(compressionQuality: 0.7)
                newCompany.setValue(imageData, forKey: "imageData")
            }
            CoreDataManager.shared.saveContext()
            dismiss(animated: true) {
                self.delegate?.addCompanyDidFfinish(company: newCompany as! Company)
            }
        }else {
            // edit (update)
            company?.name = nameTextField.text
            company?.applied = datePicker.date
            if let companyImage = companyImageView.image {
                let imageData = companyImage.jpegData(compressionQuality: 0.7)
                company?.imageData = imageData
            }
            CoreDataManager.shared.saveContext()
            dismiss(animated: true) {
                self.delegate?.editCompanyDidFinish(company: self.company!)
            }
        }
        
    }

}

extension AddCompanyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[.editedImage] as? UIImage {
            companyImageView.image = editedImage
        }else if let originalImage = info[.originalImage] as? UIImage {
        companyImageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
