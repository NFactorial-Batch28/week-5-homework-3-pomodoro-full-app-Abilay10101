//
//  ViewController.swift
//  PomodoroUIKit
//
//  Created by Arip Khozhbanov on 07.05.2023.
//

import UIKit

class ViewController: UIViewController {

    var imgStr = "BG0"
    var timee = Timee(workingTime: 25 * 60, restingTime: 5 * 60, workSt: true)
    
    var timer: Timer?
    var timeLeft = 0
    var timerWorks = false
    
    var focusCatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Focus Category", for: .normal)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 16)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget( self , action: #selector(focusAct), for: .touchUpInside)
        return button
    }()
    
    var circleView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 124
        view.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).cgColor
        view.layer.borderWidth = 5
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "25:00"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next Bold", size: 44)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var underLabel: UILabel = {
        let label = UILabel()
        label.text = "Focus on your task"
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        button.layer.cornerRadius = 28
        button.addTarget( self , action: #selector(playAct), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "stop"), for: .normal)
        button.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        button.layer.cornerRadius = 28
        button.addTarget( self , action: #selector(stopAct), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house.circle.fill"),tag: 1)
        
        setViews()
        setupConstraints()
        timeLeft = timee.workingTime
        timeLabel.text = timeString(time: TimeInterval(timeLeft))
    }

    func setViews() {
        let backgroundImage = UIImage(named: imgStr)
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = UIColor(patternImage: backgroundImage!)
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
        
        view.addSubview(focusCatButton)
        view.addSubview(circleView)
        circleView.addSubview(timeLabel)
        circleView.addSubview(underLabel)
        view.addSubview(playButton)
        view.addSubview(stopButton)
    }
    
    //MARK: - Button Methods
    
    @objc func focusAct() {
        
    }
    
    @objc func playAct() {
        if timerWorks {
            playButton.setImage(UIImage(systemName: "play"), for: .normal)
            stopTimer()
        } else {
            playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            startTimer()
            
        }
    }
    
    @objc func stopAct() {
        stopTimer()
        timeLeft = timee.workingTime
        timeLabel.text = timeString(time: TimeInterval(timeLeft))
        timerWorks = false
    }
    
    //MARK: - Timer Funcs
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        timerWorks = true
    }
        
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
        
    @objc func timerTick() {
        if timeLeft <= 0 {
            if timee.workSt {
                timeLeft = timee.restingTime
            } else {
                timeLeft = timee.workingTime
            }
            
            //stopTimer()
                
            return
        }
        timeLeft -= 1
        timeLabel.text = timeString(time: TimeInterval(timeLeft))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    

}




extension ViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            focusCatButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            focusCatButton.heightAnchor.constraint(equalToConstant: 36),
            focusCatButton.widthAnchor.constraint(equalToConstant: 170),
            focusCatButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            circleView.heightAnchor.constraint(equalToConstant: 248),
            circleView.widthAnchor.constraint(equalToConstant: 248),
            circleView.topAnchor.constraint(equalTo: focusCatButton.bottomAnchor, constant: 50),
            circleView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            timeLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: -20),
            timeLabel.heightAnchor.constraint(equalToConstant: 56),
            
            underLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            underLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0),
            underLabel.heightAnchor.constraint(equalToConstant: 24),
            
            playButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -40),
            playButton.heightAnchor.constraint(equalToConstant: 56),
            playButton.widthAnchor.constraint(equalToConstant: 56),
            
            stopButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 30),
            stopButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 40),
            stopButton.heightAnchor.constraint(equalToConstant: 56),
            stopButton.widthAnchor.constraint(equalToConstant: 56)
            
            
        ])
        
    }
    
}
