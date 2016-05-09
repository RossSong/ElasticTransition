//
//  InitialViewController.swift
//  ElasticTransitionExample
//
//  Created by Luke Zhao on 2015-12-16.
//  Copyright © 2015 lkzhao. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
  
  
  var transition = ElasticTransition()
  let lgr = UIScreenEdgePanGestureRecognizer()
  let rgr = UIScreenEdgePanGestureRecognizer()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // customization
    transition.sticky = true
    transition.showShadow = true
    transition.panThreshold = 0.3
    transition.transformType = .TranslateMid
    
//    transition.overlayColor = UIColor(white: 0, alpha: 0.5)
//    transition.shadowColor = UIColor(white: 0, alpha: 0.5)
    
    // gesture recognizer
    lgr.addTarget(self, action: #selector(InitialViewController.handlePan(_:)))
    rgr.addTarget(self, action: #selector(InitialViewController.handleRightPan(_:)))
    lgr.edges = .Left
    rgr.edges = .Right
    view.addGestureRecognizer(lgr)
    view.addGestureRecognizer(rgr)
  }
  
  func handlePan(pan:UIPanGestureRecognizer){
    if pan.state == .Began{
      transition.edge = .Left
      transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
    }else{
      transition.updateInteractiveTransition(gestureRecognizer: pan)
    }
  }
  
  func handleRightPan(pan:UIPanGestureRecognizer){
    if pan.state == .Began{
      transition.edge = .Right
      transition.startInteractiveTransition(self, segueIdentifier: "about", gestureRecognizer: pan)
    }else{
      transition.updateInteractiveTransition(gestureRecognizer: pan)
    }
  }
  
  @IBAction func codeBtnTouched(sender: AnyObject) {
    transition.edge = .Left
    transition.startingPoint = sender.center
    performSegueWithIdentifier("menu", sender: self)
  }
  
  @IBAction func optionBtnTouched(sender: AnyObject) {
    transition.edge = .Bottom
    transition.startingPoint = sender.center
    performSegueWithIdentifier("option", sender: self)
  }

  @IBAction func aboutBtnTouched(sender: AnyObject) {
    transition.edge = .Right
    transition.startingPoint = sender.center
    performSegueWithIdentifier("about", sender: self)
  }
  
  @IBAction func modalBtnTouched(sender: AnyObject) {
    let modalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("modalExample") as! ModalExampleViewController
    presentViewController(modalViewController, animated: true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let vc = segue.destinationViewController
    vc.transitioningDelegate = transition
    vc.modalPresentationStyle = .Custom
  }
  
}
