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
    
    // Array that holds the players move
    var playerMoves: [IntegerLiteralType] = [];
    
    // Properties
    @IBOutlet var redButton: UIButton!
    @IBOutlet var greenButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var yellButton: UIButton!
    
    var buttons: [UIButton] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = [redButton, greenButton, blueButton, yellButton];
        
//        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.gameplay), userInfo: nil, repeats: true);
        
        self.gameplay();

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    @objc func highlightButton(button: UIButton) {
//
//        button.isHighlighted = true;
//        highlightTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){_ in
//            button.isHighlighted = false;
//        }
//    }
    
    // Takes the order of the inputs and displays them
    @objc func displayOrder(buttonOrder: [Int]){
        
        // Move through the list and display the buttons in that order
        var currOffset: Double = 0;
        for i in 0..<buttonOrder.count{
            currOffset += 1;
            timer = Timer.scheduledTimer(withTimeInterval: currOffset, repeats: false){_ in
                self.buttons[buttonOrder[i]].isHighlighted = true;
                self.highlightTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){_ in
                    self.buttons[buttonOrder[i]].isHighlighted = false;
                }
            }
        }
        
//        timer = Timer.scheduledTimer(withTimeInterval: currOffset, repeats: false){_ in
//            self.turnOnButtons();
//        }
    }
    
    //MARK: Actions
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        
        if(sender == redButton)
        {
            playerMoves.append(0);
        }
        else if(sender == greenButton)
        {
            playerMoves.append(1);
        }
        else if(sender == blueButton)
        {
            playerMoves.append(2);
        }
        else if(sender == yellButton)
        {
            playerMoves.append(3);
        }
        
        // Turn off the buttons for further interactions and start the calculations to see if the player input the correct moves
        if(playerMoves.count >= order.count)
        {
            turnOffButtons();
            playerTurn();
        }
    }
    
    // Contains the main play cycle for the game
    @objc func gameplay() {
        
        // Add a random number, that depicts the image to pick, to the end of the order
        order.append(Int.random(in: 0 ... 3));
        
        // Turn off buttons for pressing
        turnOffButtons();
        
        // Move through the order of the images displaying which ones should be pressed
        playerMoves.removeAll();
        self.displayOrder(buttonOrder: order);
        
        // Turn the buttons back on after the
        turnOnButtons();
    }
    
    //  function that checks the moves to see if the user input the correct order of buttons
    func playerTurn() {
        if playerMoves.count == order.count {
            for i in 0..<order.count{
                if playerMoves[i] != order[i]{
                    print("Wrong answer!!!!")
                    return;
                }
            }
            
            self.gameplay();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Will disappear");
        self.timer.invalidate();
        highlightTimer.invalidate();
    }
    
    // Turn off the buttons
    func turnOffButtons() {
//        print("Here");
        redButton.isEnabled = false;
        blueButton.isEnabled = false;
        greenButton.isEnabled = false;
        yellButton.isEnabled = false;
    }
    
    // Turn on the buttons
    func turnOnButtons() {
        print("Here");
        redButton.isEnabled = true;
        blueButton.isEnabled = true;
        greenButton.isEnabled = true;
        yellButton.isEnabled = true;
    }

}
