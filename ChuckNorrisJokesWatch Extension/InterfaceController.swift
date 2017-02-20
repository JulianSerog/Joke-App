//
//  InterfaceController.swift
//  ChuckNorrisJokesWatch Extension
//
//  Created by Esa Serog on 2/4/17.
//  Copyright © 2017 Julian Serog. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var jokeLbl: WKInterfaceLabel!
    @IBOutlet var newJokeBtn: WKInterfaceButton!
    let url = URL(string: "https://api.icndb.com/jokes/random?exclude=explicit")

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        getJokeFromAPI()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //TODO: make label size dynamic for big jokes
    func getJokeFromAPI() {
        var joke: String? = nil
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                //show error message to user
                DispatchQueue.main.async {
                    self.jokeLbl.setText("Internet connection required to retrieve jokes!")
                    self.jokeLbl.setTextColor(UIColor.red)
                }//main thread
                print("error with request: \(error)")
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    let sub_dict = json["value"] as! [String : AnyObject]
                    joke = sub_dict["joke"] as! String?
                    
                    
                    //update ui
                    DispatchQueue.main.async {
                        self.jokeLbl.setTextColor(UIColor.white)
                        joke = self.parseJoke(joke: joke!)
                        print("new joke in main thread: \(joke)")
                        self.jokeLbl.setText(joke)
                    }
                    
                    //print("JSON: \n\(json)")
                    //TODO: grab joke string from json
                }catch let error as NSError{
                    //if there is an error, show error message to user
                    DispatchQueue.main.async {
                        self.jokeLbl.setText("Internet connection required to retrieve jokes!")
                        self.jokeLbl.setTextColor(UIColor.red)
                    }
                    print(error)
                }//catch
            }//else
            //end lambda
        }.resume()
    }//httpGetRequest
    
    func parseJoke(joke: String) -> String {
        let singleQuote = "?"
        let quote = "&quot;"
        var newJoke = joke
        if (newJoke.contains(quote)) {
            newJoke = newJoke.replacingOccurrences(of: quote, with: "\"")
        }
        if (newJoke.contains(singleQuote)) {
            newJoke = newJoke.replacingOccurrences(of: singleQuote, with: "\'")
        }
        return newJoke
    }
    
    
    @IBAction func newJokePressed() {
        getJokeFromAPI()
    }

}
