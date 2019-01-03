//
//  GameViewController.swift
//  Matching Game
//
//  Created by Terrance Griffith on 12/27/18.
//  Copyright © 2018 Terrance Griffith. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // Variables
    var timer = Timer();
    var highlightTimer = Timer();
    
    // An array that contains the order of the matching game
    var order: [IntegerLiteralType] = [];
    
    // Properties
    @IBOutlet var redButton: UIButton!
    @IBOutlet var greenButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var yellButton: UIButton!
    
    var buttons: [UIButton] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [redButton, greenButton, blueButton, yellButton];
        
        timer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(self.gameplay), userInfo: nil, repeats: true);

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func highlightButton(button: UIButton) {
        
        button.isHighlighted = true;
        highlightTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){_ in
            button.isHighlighted = false;
        }
    }
    
    // Takes the order of the inputs and displays them
    @objc func displayOrder(buttonOrder: [Int]){
        
        // Move through the list and display the buttons in that order
        var currOffset: Double = 0;
        for i in 0..<buttonOrder.count{
//            DispatchQueue.global().sync{
//                self.highlightButton(button: self.buttons[buttonOrder[i]])
            currOffset += 1;
            timer = Timer.scheduledTimer(withTimeInterval: currOffset, repeats: false){_ in
                self.buttons[buttonOrder[i]].isHighlighted = true;
                self.highlightTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){_ in
                    self.buttons[buttonOrder[i]].isHighlighted = false;
                }
            }
//            }
        }
//        print();
    }
    
//    timer =  Timer.scheduledTimer(timeInterval: 2.0, target: self, selector:#selector(YourViewController.changeText), userInfo: nil, repeats: true)

    
    //MARK: Actions
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        
        if(sender == redButton)
        {
            print("red button pressed");
        }
    }
    
    // Contains the main play cycle for the game
    @objc func gameplay() {
        
        // Add a random number, that depicts the image to pick, to the end of the order
        order.append(Int.random(in: 0 ... 3));
        
        // Move through the order of the images displaying which ones should be pressed
        self.displayOrder(buttonOrder: order);
        
    }

}
