//
//  ViewController.swift
//  CubeSlideApp
//
//  Created by Nikolay Pochekuev on 09.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func slider(sender: UISlider, event: UIEvent) {
        setupAnimation(sender: sender)
        
        let touch = event.allTouches?.first
        if touch?.phase == .ended {
            sender.setValue(sender.maximumValue, animated: true)
            setupAnimation(sender: sender)
        }
    }

    var containerView = UIView()
    var squareView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemBlue
        return view
    }()
    var sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(slider(sender:event:)), for: .valueChanged)
        return slider
    }()
}

private extension ViewController {
    func setup() {
        view.addSubview(containerView)
        containerView.addSubview(squareView)
        view.addSubview(sliderView)
        makeConstraints()
    }

    func setupAnimation(sender: UISlider) {
        let value = CGFloat(sender.value)
        let angle = value * CGFloat.pi / 2
        let scale = 1.0 + value / 2
        
        let translation = (view.frame.width - squareView.layoutMarginsGuide.layoutFrame.origin.x - 100 * 1.5) * value
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.squareView.transform = CGAffineTransform(translationX: translation, y: 0)
                .rotated(by: angle)
                .scaledBy(x: scale, y: scale)
        }
    }
    
    func makeConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  16),
            containerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        squareView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            squareView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            squareView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            squareView.widthAnchor.constraint(equalToConstant: 100),
            squareView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            sliderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sliderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            sliderView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
