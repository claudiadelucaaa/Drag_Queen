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
    @IBOutlet weak var biancaMove: UIImageView!

    private var biancaTimer: Timer?
    private var buttonTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Timer para la animación de Bianca (cada 5 segundos)
        biancaTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.animateBianca()
        }

        // Timer para la animación del botón (cada 1.5 segundos)
        buttonTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in
            UIView.animate(withDuration: 0.5) {
                self?.pressToStartButton.alpha = 0.5
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self?.pressToStartButton.alpha = 1
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

    func animateBianca() {
        UIView.transition(with: biancaMove, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.biancaMove.image = UIImage(named: "Bianca1")
        }) { _ in
            UIView.transition(with: self.biancaMove, duration: 0.1, options: .transitionCrossDissolve, animations: {
                self.biancaMove.image = UIImage(named: "Bianca2")
            }) { _ in
                UIView.transition(with: self.biancaMove, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.biancaMove.image = UIImage(named: "Bianca3")
                }){ _ in
                    UIView.transition(with: self.biancaMove, duration: 0.1, options: .transitionCrossDissolve, animations: {
                        self.biancaMove.image = UIImage(named: "Bianca4")
                    }){ _ in
                        UIView.transition(with: self.biancaMove, duration: 0.1, options: .transitionCrossDissolve, animations: {
                            self.biancaMove.image = UIImage(named: "Bianca5")
                        }, completion: nil)
                    }
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


//
//import SpriteKit
//import UIKit
//
//class StartViewController2: UIViewController {
//
//    @IBOutlet weak var pressToStartButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in
//            self?.animateBianca()
//        }
//
//        startButtonBlinking()
//    }
//
//    
//
//    func startButtonBlinking() {
//        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
//            self.pressToStartButton.alpha = 0
//        }, completion: { _ in
//            self.pressToStartButton.alpha = 1
//        })
//    }
//
//    @IBAction func pressToStartButtonPressed(_ sender: Any) {
//        guard let vc = storyboard?.instantiateViewController(identifier: "gameVC") as? GameViewController else {
//            fatalError()
//        }
//        present(vc, animated: false)
//    }
//
//    override var shouldAutorotate: Bool {
//        return true
//    }
//}
//*/
