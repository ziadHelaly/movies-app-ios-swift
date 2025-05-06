//
//  MoviesTableViewController.swift
//  movies
//
//  Created by ziad helaly on 27/04/2025.
//
import UIKit

class MoviesTableViewController:UITableViewController,AddDelegate{
    let myDataSource = MyDataSoucre.instance
    var movies:[Movie] = MyDataSoucre.instance.movies
    func add(movie: Movie) {
        myDataSource.add(movie:movie)
        movies = myDataSource.movies
        tableView.reloadData()
    }
    
    
//    var movies:[Movie] =
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))

                
    }
    @objc func addMovie() {
        if let addMovieVC = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController {
                addMovieVC.table = self
                navigationController?.pushViewController(addMovieVC, animated: true)
            }

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label?.text = movies[indexPath.row].title
        if let image = UIImage(contentsOfFile: movies[indexPath.row].image) {
            cell.img?.image = image
        }else{
            cell.img?.image = UIImage.init(named: "1")
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: movies[indexPath.row])

    }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetails" {
                if let VC = segue.destination as? ViewController,
                   let selectedMovie = sender as? Movie {
                    VC.movie = selectedMovie
                }
            }
        
    }
    

}
