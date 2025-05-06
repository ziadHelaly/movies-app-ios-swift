//
//  MyDataSoucre.swift
//  movies
//
//  Created by ziad helaly on 30/04/2025.
//

import Foundation
import SQLite3
class MyDataSoucre {
    static let instance = MyDataSoucre()
    var movies:[Movie]
    let dbPath: String? = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.first?.appendingPathComponent("db.sqlite").path
    }()
    var dbPointer:OpaquePointer?


    private init(){
        movies=[
            Movie(title: "movie 1", image: "1", rating: 5.0, releaseYear: 2002, genre: ["action"]),
            Movie(title: "movie 2", image: "2", rating: 3.0, releaseYear: 2003, genre: ["musical"]),
            Movie(title: "movie 3", image: "3", rating: 4.0, releaseYear: 2004, genre: ["light"]),
            Movie(title: "movie 4", image: "4", rating: 5.0, releaseYear: 2006, genre: ["drama"]),
            Movie(title: "movie 5", image: "5", rating: 2.0, releaseYear: 2005, genre: ["action" , "comedy"]),
        ]
        self.dbPointer = openDataBase()
        creatTable()
        read()
        
    }
    func add(movie:Movie) {
        movies.append(movie)
        insert(movie: movie)
    }
    func openDataBase () -> OpaquePointer? {
        
        var db: OpaquePointer?
        guard let dbPath = dbPath else {
            print("database Path is nil.")
            return nil
        }
       if sqlite3_open(dbPath, &db) == SQLITE_OK
            {
           print("successfully opened connection to database at \(dbPath)")
           return db
       }else{
           print("Unable to open database !!! ")
           return nil
       }
    }
    // ---- Create Table -----

    let createTableQueryString = """
    CREATE TABLE IF NOT EXISTS movies (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                image TEXT,
                rating REAL,
                releaseYear INTEGER,
                genre TEXT
            );
    """
    func creatTable () {
        var creatTableStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(dbPointer, createTableQueryString, -1, &creatTableStatement, nil) == SQLITE_OK{
            print("prepared statment completed successfully")
            if sqlite3_step(creatTableStatement) == SQLITE_DONE{
                print("Table contact created successfully   ")
            }else{
                print("Table contact is not created  !!  ")
            }
        }else{
            print("unable to prepare statment  ")
        }
        sqlite3_finalize(creatTableStatement)
    }

    let insertQueryString =  "INSERT INTO movies (title, image, rating, releaseYear, genre) VALUES (?, ?, ?, ?, ?);"  //1
    func insert (movie:Movie) {
        var stmt : OpaquePointer? //2
       //3
        if sqlite3_prepare_v2(dbPointer, insertQueryString, -1, &stmt, nil) == SQLITE_OK {
            print("insert statment prepared successfully  ")
            
            sqlite3_bind_text(stmt, 1, (movie.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, (movie.image as NSString).utf8String, -1, nil)
            sqlite3_bind_double(stmt, 3, Double(movie.rating))
            sqlite3_bind_int(stmt, 4, Int32(movie.releaseYear))
            sqlite3_bind_text(stmt, 5, (movie.genre.joined(separator: ",") as NSString).utf8String, -1, nil)

            //4
            if sqlite3_step(stmt) == SQLITE_DONE {
                print(" successfully insert row  ")
            }else{
                print("unable to  insert   ")
            }
            
        }else{
            print("unable to prepare insert statment  ")
        }
        //5
        sqlite3_finalize(stmt)
    }
    let selecQueryString = "SELECT * FROM movies;"
    func read()  {
        var stmt : OpaquePointer?
        
        if sqlite3_prepare_v2(dbPointer, selecQueryString, -1, &stmt, nil) == SQLITE_OK {
            print("select statment  prepared successfully ")
            
            while sqlite3_step(stmt) == SQLITE_ROW {
                let title = String(cString: sqlite3_column_text(stmt, 1))
                let image = String(cString: sqlite3_column_text(stmt, 2))
                let rating = Float(sqlite3_column_double(stmt, 3))
                let releaseYear = Int(sqlite3_column_int(stmt, 4))
                let genreString = String(cString: sqlite3_column_text(stmt, 5))
                let genre = genreString.components(separatedBy: ",")
                let movie = Movie(title: title, image: image, rating: rating, releaseYear: releaseYear, genre: genre)
                movies.append(movie)
            }
            
        }   else{
            print("unable to prepare Select statment  ")
        }
        sqlite3_finalize(stmt)
        
    }


}
