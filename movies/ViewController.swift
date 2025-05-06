//
//  ViewController.swift
//  movies
//
//  Created by ziad helaly on 27/04/2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genra: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var img: UIImageView!
    var movie : Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if movie != nil{
            titleLabel.text = movie?.title
            ratingLabel.text = String(movie!.rating)
            genra.text = movie?.genre[0]
            date.text = String( movie!.releaseYear)
            if let image = UIImage(contentsOfFile: movie?.image ?? "1") {
                img.image = image
            }else{
                img.image = UIImage.init(named: "1")
            }
        }
    }


}

