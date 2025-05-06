//
//  AddViewController.swift
//  movies
//
//  Created by ziad helaly on 28/04/2025.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var table: AddDelegate?
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var ratingTf: UITextField!
    @IBOutlet weak var genreTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    var selectedImageURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func done(_ sender: Any) {
        if let title = titleTF.text, !title.isEmpty,
               let ratingText = ratingTf.text, let rating = Float(ratingText),
               let genreText = genreTF.text, !genreText.isEmpty,
               let dateText = dateTF.text, let releaseYear = Int(dateText) {
            
                let genre = [genreText]
                var imagePath = ""
                if let selectedURL = selectedImageURL {
                        imagePath = selectedURL.path
                    }

                let movie = Movie(title: title, image: imagePath, rating: rating, releaseYear: releaseYear, genre: genre)
            
                table?.add(movie: movie)
                navigationController?.popViewController(animated: true)
                
            } else {
                print("Please fill all fields correctly")
            }
    }
    
    
    @IBAction func addImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as?UIImage {
            imgView.image = image
        }
        if let url = info[.imageURL] as? URL {
                selectedImageURL = url
            }

        picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
