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
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        getJokeFromAPI()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //TODO: fix threading issues when parsing special characters in joke
    func getJokeFromAPI() {
        var joke: String? = nil
        //TODO: make request
        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                //show error message to user
                DispatchQueue.main.async {
                    self.jokeLbl.setText("Internet connection required to retrieve jokes!")
                    self.jokeLbl.setTextColor(UIColor.red)
                }
                print("error with request: \(error)")
            } else {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                   
                    print("VALUE:\n\(json["value"]!)")
                    let sub_dict = json["value"] as! [String : AnyObject]  //json["value"]["joke"]
                    print(sub_dict["joke"]!)
                    joke = sub_dict["joke"] as! String?
                    let singleQuote = "?"
                    let quote = "@quot;"
                    
                    if (joke?.contains(quote))! {
                        joke = joke?.replacingOccurrences(of: quote, with: "\"")
                    }
                    if (joke?.contains(singleQuote))! {
                        joke = joke?.replacingOccurrences(of: singleQuote, with: "\'")
                    }
                    
                    //update ui
                    DispatchQueue.main.async {
                        self.jokeLbl.setTextColor(UIColor.white)
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
    
    
    @IBAction func newJokePressed() {
        getJokeFromAPI()
    }

}
