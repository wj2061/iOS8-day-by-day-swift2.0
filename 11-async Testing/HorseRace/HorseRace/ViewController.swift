//
//  ViewController.swift
//  HorseRace
//
//  Created by WJ on 15/10/31.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {
    @IBOutlet public weak var horse1: UIImageView!
    @IBOutlet public weak var horse2: UIImageView!
    
    @IBOutlet  weak var horse1StartConstraint: NSLayoutConstraint!
    @IBOutlet weak var horse2StartConstraint: NSLayoutConstraint!
    
    @IBOutlet public weak var resetButton: UIButton!
    @IBOutlet public weak var startRaceButton: UIButton!
    
    public var raceController: TwoHorseRaceController!
    private var numberOfHorsesCurrentlyRunning = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        horse1.frame = CGRect(x: 15, y: 40, width: 100, height: 100)
        horse2.frame = CGRect(x: 15, y: 200, width: 100, height: 100)
        
        raceController = createRaceController()
        resetButton.enabled = false
        
    }
    
    @IBAction public func start(sender: UIButton) {
        numberOfHorsesCurrentlyRunning = 2
        startRaceButton.enabled = false
        raceController.startRace(5, horseCrossedLineCallback:{
            (horse:Horse) in
            // Deal with the number of horses
            self.numberOfHorsesCurrentlyRunning -= 1
            if self.numberOfHorsesCurrentlyRunning == 0 {
                self.resetButton.enabled = true
            }
            
            switch horse.horseView {
            case self.horse1:
                print("Horse 1 has completed the race!")
            case self.horse2:
                print("Horse 2 has completed the race!")
            default:
                print("That horse wasn't in the race")
            }
        })
    }
    
    @IBAction public func restart(sender: AnyObject) {
        raceController.reset()
        resetButton.enabled = false
        startRaceButton.enabled = true
    }




    // Utility methods
    func createRaceController() -> TwoHorseRaceController {
        let h1 = Horse(horseView: horse1, startFrame: horse1.frame, finishLineOffset: 10)
        let h2 = Horse(horseView: horse2, startFrame: horse2.frame, finishLineOffset: 10)
        return TwoHorseRaceController(horses: [h1, h2])
    }
}

