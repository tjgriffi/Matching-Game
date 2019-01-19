//
//  GameViewController.swift
//  Matching Game
//
//  Created by Terrance Griffith on 12/27/18.
//  Copyright © 2018 Terrance Griffith. All rights reserved.
//

import UIKit

protocol endGameDelegate: class {
    func restartGameButtonPressed()
}

class endGameView: UIView{
    weak var delegate: endGameDelegate?

    
    required init(frame: CGRect, pDelegate: endGameDelegate){
        super.init(frame: frame);
        self.delegate = pDelegate;
        
        self.backgroundColor = UIColor.red;
        
        let restartButtonFrame = CGRect(x: self.frame.width/2, y: self.frame.height/4, width: 50, height: 50);
        let restartButton = UIButton(frame: restartButtonFrame );
        restartButton.backgroundColor = UIColor.blue;
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside);
        
        self.addSubview(restartButton);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func restartGame(sender: UIButton) {
        delegate?.restartGameButtonPressed();
    }
}

class GameViewController: UIViewController, endGameDelegate {
    
    // Variables
    var timer = Timer();
    var highlightTimer = Timer();
    
    // An array that contains the order of the matching game
    var order: [IntegerLiteralType] = [];
    
    // Array that holds the players move
    var playerMoves: [IntegerLiteralType] = [];
    
    // Endgame popup
    var endGamePopUp: UIView!;
    
    // Properties
    @IBOutlet var redButton: UIButton!
    @IBOutlet var greenButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var yellButton: UIButton!
    
    var buttons: [UIButton] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the endgame popup
//        endGamePopUp.isHidden = true;
        
        // Add all of the buttons to an array to keep track of them
        buttons = [redButton, greenButton, blueButton, yellButton];
        
        // create the endgame popup
        self.createTheEndGamePopUp();
        
        self.gameplay();

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // Create the endgame pop up
    func createTheEndGamePopUp() {
        
        let endGameViewFrame = CGRect.init(x: CGFloat(view.frame.width/4), y: CGFloat(view.frame.height/4), width: CGFloat(view.frame.width/2), height: view.frame.height/4);
        endGamePopUp = endGameView(frame: endGameViewFrame, pDelegate: self);
        
        self.view.addSubview(endGamePopUp);
                
        endGamePopUp.isHidden = true;
        
    }
    
    @objc func restartGameButtonPressed() {
        // Clear the order array
        order = [];
        
        // Hide the endgame pop up
        endGamePopUp.isHidden = true;
        
        // Run the gameplay sequence again
        self.gameplay();
        
        
        print("Restart was pressed!!!");
    }
    
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
        
    }
    
    //MARK: Actions
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        
        // Add the button(index of the button) that was pressed to the moveset
        playerMoves.append(buttons.firstIndex(of: sender)!);
        
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
//                    print("Wrong answer!!!!")
                    loadEndGameVew();
                    return;
                }
            }
            
            self.gameplay();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate();
        highlightTimer.invalidate();
    }
    
    // Turn off the buttons
    func turnOffButtons() {
        redButton.isEnabled = false;
        blueButton.isEnabled = false;
        greenButton.isEnabled = false;
        yellButton.isEnabled = false;
    }
    
    // Turn on the buttons
    func turnOnButtons() {
        redButton.isEnabled = true;
        blueButton.isEnabled = true;
        greenButton.isEnabled = true;
        yellButton.isEnabled = true;
    }
    
    func loadEndGameVew(){
//        print("The endgame popup should appear");
        endGamePopUp.isHidden = false;
    
    }

}
