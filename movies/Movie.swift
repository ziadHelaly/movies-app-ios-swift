//
//  Movie.swift
//  movies
//
//  Created by ziad helaly on 27/04/2025.
//

import Foundation
class Movie{
    var title : String
    var image : String
    var rating : Float
    var releaseYear : Int
    var genre : [String]
    init(
        title : String,
        image : String,
        rating : Float,
        releaseYear : Int,
        genre : [String]
    ){
        self.title = title
        self.image = image
        self.rating = rating
        self.releaseYear = releaseYear
        self.genre = genre
    }
}
