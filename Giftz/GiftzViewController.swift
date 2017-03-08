//
//  GiftzViewController.swift
//  Giftz
//
//  Created by Leiter Family on 3/7/17.
//  Copyright © 2017 40° Degrees Media, Ltd. All rights reserved.
//

import UIKit

class GiftzViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var giftzImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var gift : Gift? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if gift != nil {
            giftzImageView.image = UIImage(data: gift!.image as! Data)
            titleTextField.text = gift!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        }
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
    }
    
    @IBAction func myPhotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        giftzImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let gift = Gift(context: context)
        gift.title = titleTextField.text
        gift.image = UIImagePNGRepresentation(giftzImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}
