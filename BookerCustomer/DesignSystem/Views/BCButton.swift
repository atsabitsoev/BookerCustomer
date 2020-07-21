//
//  BCButton.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 21.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BCButton: UIButton {
    
    enum State {
        case tapMe
        case waiting
        case ready
    }
    
    private let tapMeTitle: String
    private let waitingTitle: String
    private let readyTitle: String
    
    var buttonState: State
    
    
    init(
        buttonState: State,
        tapMeTitle: String,
        waitingTitle: String,
        readyTitle: String
        ) {
        self.buttonState = buttonState
        self.tapMeTitle = tapMeTitle
        self.waitingTitle = waitingTitle
        self.readyTitle = readyTitle
        super.init(frame: .zero)
        layer.cornerRadius = 16
        setTitleColor(UIColor.Button.title, for: .normal)
        titleLabel?.font = UIFont.Button.primary
        setButtonState(to: buttonState)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getButtonState() -> State {
        return buttonState
    }
        
    func setButtonState(to state: State) {
        switch state {
        case .tapMe:
            backgroundColor = UIColor.Button.tapOnMe
            setTitle(tapMeTitle, for: .normal)
            isUserInteractionEnabled = true
        case .waiting:
            backgroundColor = UIColor.Button.waiting
            setTitle(waitingTitle, for: .normal)
            isUserInteractionEnabled = false
        case .ready:
            backgroundColor = UIColor.Button.ready
            setTitle(readyTitle, for: .normal)
            isUserInteractionEnabled = false
        }
        self.buttonState = state
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }
        }
    }
    
}
