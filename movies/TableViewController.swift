//
//  TableViewController.swift
//  movies
//
//  Created by JETSMobileLab9 on 06/05/2025.
//

import UIKit

class TableViewController: UITableViewController  ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var table: AddDelegate?
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var ratingTf: UITextField!
    @IBOutlet weak var genreTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    var selectedImageURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
