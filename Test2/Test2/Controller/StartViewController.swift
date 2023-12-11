//
//  StartViewController.swift
//  DragGame
//
//  Created by yatziri on 07/12/23.
//
import UIKit
import SpriteKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var pressToStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [self] _ in
            animateBianca()
            UIView.animate(withDuration: 0.5) {
                self.pressToStartButton.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.pressToStartButton.alpha = 1
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let blurView = UIVisualEffectView(frame: self.view.frame)
        blurView.alpha = 1
        blurView.effect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        self.view.addSubview(blurView)
        UIView.animate(withDuration: 3) {
            blurView.alpha = 0
        }
    }
    
    @IBOutlet weak var biancaMove: UIImageView!
    func animateBianca() {
        UIView.animate(withDuration: 6) {
            self.biancaMove.image = UIImage(named: "Bianca1")
        } completion: { _ in
            UIView.animate(withDuration: 6) {
                self.biancaMove.image = UIImage(named: "Bianca2")
            } completion: { _ in
                UIView.animate(withDuration: 6) {
                    self.biancaMove.image = UIImage(named: "Bianca5")
                }
            }
        }
    }
    
    
    @IBAction func pressToStartButtonPressed(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "gameVC") as? GameViewController else {
            fatalError()
        }
        present(vc, animated: false)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}
