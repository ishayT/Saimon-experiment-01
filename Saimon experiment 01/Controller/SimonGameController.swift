//
//  SimonGameController.swift
//  Saymon experiment 01
//
//  Created by Ishay on 2/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class SimonGameController: UIViewController {

    //MARK:- 1. all of the saimon playing buttons
    @IBOutlet weak var button1: DesignableButton!
    @IBOutlet weak var button2: DesignableButton!
    @IBOutlet weak var button3: DesignableButton!
    @IBOutlet weak var button4: DesignableButton!
    @IBOutlet weak var startButton: DesignableButton!
    
    
    //MARK:- 2. the score lives related varibals
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    var scoreNumber : Int = 0
    var numberOfLives = 3
    var numberOfRounds : Int = 0 //TODO: maybe delete this or make it as a text for the start btn
    
    
    //MARK:- 3. varibles related for playing the sounds and glow and logic in the game
    var gameTimer: Timer!
    var soundPlayer : AVAudioPlayer!
    var selectedSound : String = ""
    let arrayOfSounds = ["buttonSound1", "buttonSound2", "buttonSound3", "buttonSound4"]
    
    
    //MARK:- 4. other varibles related to logic in the game
    var gameIsOver : Bool = true
    var randomNumber : Int = 0
    var counterForTheComputerTurn : Int = 0
    
    var arrayOfBtnNumbersPlayedByTheComp: [Int] = [Int]()
    var arrayOfBtnNumbersPlayedByThePlayer: [Int] = [Int]()
    var arrayOfButtons : [UIButton] = []
    
    
    //MARK:- 5. Firebase Methods
    let playersDatabase = Database.database().reference()
    let uid : String = (Auth.auth().currentUser!.uid)
    
    
    //MARK:- 6. ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "saimon"
        
        button1.makeButtonRound();  button2.makeButtonRound();
        button3.makeButtonRound();  button4.makeButtonRound();
        
        arrayOfButtons = [button1, button2, button3, button4]
        
        //disable buttons
        changeThePlayButtons(isEnabledStatus: false, arrayOfButtons: arrayOfButtons)
    }
    
    //MARK:- 7.creating the navigation bar buttons
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "High-Score", style: .plain, target: self, action: #selector(goingToTheHighScore))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //MARK:- 8.changeThePlayButtons(isEnabledStatus) makes the 4 game buttons enable/disable
    func changeThePlayButtons(isEnabledStatus: Bool, arrayOfButtons: [UIButton]){
        for i in 0...arrayOfButtons.count - 1 {
            arrayOfButtons[i].isEnabled = isEnabledStatus
        }
    }
    
    
    //MARK:- 9.start button pressed
    @IBAction func startButtonPressed(_ sender: DesignableButton) {
        startButton.isEnabled = false
        loadNewGame()
    }
    
    
    func loadNewGame() {
        
        arrayOfBtnNumbersPlayedByTheComp.removeAll()
        scoreNumber = 0
        numberOfLives = 3
        gameIsOver = false
        self.startButton.setTitle("Start", for: .normal)
        
        randomNumber = Int(arc4random_uniform(4)+1)
        arrayOfBtnNumbersPlayedByTheComp.append(self.randomNumber)
        updateUI()
        startNewRound()
    }
    
    
    //MARK:- 10.update UI ------> need to check if i should add a text for round number and good bad ansowers on the start button
    func updateUI(){
        scoreLabel.text = "score = \(scoreNumber)"
        livesLabel.text = "Lives = \(numberOfLives)"
    }
    
    
    //MARK:- 11.start a new round of buttons played by the computer
    func startNewRound() {
        numberOfRounds += 1
        startButton.setTitle("\(numberOfRounds)", for: .normal)
        changeThePlayButtons(isEnabledStatus: false, arrayOfButtons: arrayOfButtons)
        
        arrayOfBtnNumbersPlayedByThePlayer.removeAll()
        gameTimer = Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(usingButtonsArray), userInfo: nil, repeats: true)
    }
    
    @objc func usingButtonsArray() {
        makeComputerButtonFlash(buttons: arrayOfButtons)
    }
    
    //MARK:- 12.The function that calls for the sound and animation for each button played by the computer i needed to call         this function with another @objc function(usingButtonsArray) cos the selector of the Timer couldent get varibles such as [UIButton] when calling the makeComputerButtonFlash directly
    func makeComputerButtonFlash(buttons: [UIButton]) {
        selectedSound = arrayOfSounds[arrayOfBtnNumbersPlayedByTheComp[counterForTheComputerTurn] - 1]
        
        if counterForTheComputerTurn == arrayOfBtnNumbersPlayedByTheComp.count - 1{
            
            buttons[arrayOfBtnNumbersPlayedByTheComp[counterForTheComputerTurn] - 1].flash()
            playSound()
            gameTimer.invalidate()
            counterForTheComputerTurn = 0
            changeThePlayButtons(isEnabledStatus: true, arrayOfButtons: arrayOfButtons)
            //TODO: make a label to notifiy the player it's his turn
            return
        }
        
        if counterForTheComputerTurn < arrayOfBtnNumbersPlayedByTheComp.count - 1 {
            buttons[arrayOfBtnNumbersPlayedByTheComp[counterForTheComputerTurn] - 1].flash()
            playSound()
            counterForTheComputerTurn += 1
            print([counterForTheComputerTurn - 1])
        }
    }
    
    
    //MARK:- 13. player turn
    @IBAction func gameButtonsPressedByTheUser(_ sender: DesignableButton) {
        selectedSound = arrayOfSounds[sender.tag - 1]
        arrayOfBtnNumbersPlayedByThePlayer.append(sender.tag)
        
        // adding glow and sound for the buttons
        for i in 1...4 {
            if i == sender.tag {
                sender.flash()
                playSound()
            }
        }
        
        for index in 0...arrayOfBtnNumbersPlayedByThePlayer.count-1{
            
            if arrayOfBtnNumbersPlayedByThePlayer[index] == arrayOfBtnNumbersPlayedByTheComp[index] {
                print("you are right")
                self.startButton.setTitle("Good!", for: .normal)
                scoreNumber = scoreNumber + 5 + 2 * numberOfRounds
                updateUI()
                print(scoreNumber)
            } else {
                print("you are wrong")
                self.startButton.setTitle("Bad¡", for: .normal)
                numberOfLives -= 1
                scoreNumber = scoreNumber - 5
                updateUI()
                print(scoreNumber)
                if numberOfLives == 0 {
                    gameIsOver = true
                    gameOver()
                }
                break
            }
        }
        
        if arrayOfBtnNumbersPlayedByThePlayer.count == arrayOfBtnNumbersPlayedByTheComp.count {
            randomNumber = Int(arc4random_uniform(4)+1)
            arrayOfBtnNumbersPlayedByTheComp.append(self.randomNumber)
            if !gameIsOver {
                print(gameIsOver)
                startNewRound()
            }
        }
    }
    
    
    //MARK:- 14.Game Over Method
    func gameOver() {
        print("GAME OVER!!")
        numberOfRounds = 0
        
        checkForHighScore()
        
        let gameOverAlert = UIAlertController(title: "GAME OVER", message: "Your Score Is: \(scoreNumber)", preferredStyle: .alert)
        
        let startOver = UIAlertAction(title: "Start Over", style: .default) { (startOver) in
            self.loadNewGame()
        }
        
        let goToHighScore = UIAlertAction(title: "High Score", style: .default) { (seeHighScore) in
            print("go to high Score")
            self.goingToTheHighScore()
        }
        gameOverAlert.addAction(startOver)
        gameOverAlert.addAction(goToHighScore)
        present(gameOverAlert, animated: true, completion: nil)
    }
    
    
    //MARK:- 15. the method that takes the high score of the user from the firebase database and check if the score is bigger then it if it is the score value reaplace the high score value in the db
    func checkForHighScore() {
        let childName : String = "users/\(uid)/highscore"
        playersDatabase.child(childName).observe(.value) { (snapshot) in
            
            print("snapshot=\(snapshot)")
            
            let hidhSC : Int = snapshot.value as! NSInteger
            self.updateHiScoreInDB(currentHiScore: hidhSC)
        }
    }
    
    func updateHiScoreInDB(currentHiScore: Int){
        let cond : Bool = currentHiScore < scoreNumber
        if cond {
            playersDatabase.child("users/\(uid)/highscore").setValue(scoreNumber)
        }
    }
    
    
    //MARK:- 16.playSound method - play the selected sound from the sound array
    func playSound(){
        let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "wav")
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        soundPlayer.play()
    }
    
    
    //MARK:- 17. logout method
    @objc func logout(){
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Logout Failed")
        }
    }

    @objc func goingToTheHighScore() {
        performSegue(withIdentifier: "goToHighScoreFromGame", sender: self)
    }
    
    
}
