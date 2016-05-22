//
//  CallViewController.swift
//  Call
//
//  Created by 风起兮 on 16/5/20.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit

class CallViewController: UITableViewController {
    
    
    private var open = true {
        didSet{
            changeDisplayTabBarItem()
            inputKeypadAnimate(open)
        }
    }
    
    private var firstShow = true
    
    private lazy var inputKeypadView: InputKeypadView =  {
        [weak self] in
        let inputKeypadView = InputKeypadView.loadFromXIB()
        inputKeypadView.translatesAutoresizingMaskIntoConstraints = false
        return inputKeypadView
        
    }()
    
    
    private var inputKeypadViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.delegate  = self

        configInputKeypad()
    }
    
    private func configInputKeypad () {
        let tabBar = tabBarController!.tabBar
        let tabBarControllerView = tabBarController!.view
        tabBarControllerView.insertSubview(inputKeypadView, belowSubview: tabBar)
        let views = ["inputKeypadView":inputKeypadView,"tabBar":tabBar]
        let inputKeypadViewWidthConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[inputKeypadView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        inputKeypadViewBottomConstraint = NSLayoutConstraint(item: inputKeypadView, attribute: .Bottom, relatedBy: .Equal, toItem: tabBar, attribute: .Top, multiplier: 1.0, constant: 0)
        let inputKeypadViewHeightConstraint = NSLayoutConstraint(item: inputKeypadView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 250)
        tabBarControllerView.addConstraints(inputKeypadViewWidthConstraint)
        tabBarControllerView.addConstraint(inputKeypadViewBottomConstraint)
        tabBarControllerView.addConstraint(inputKeypadViewHeightConstraint)
    }
    
    private func inputKeypadAnimate(up: Bool) {
        
        inputKeypadViewBottomConstraint.constant = up ? 0 : 250
        
        UIView.animateWithDuration(0.25) { 
            
            self.tabBarController?.view.layoutIfNeeded()
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        inputKeypadView.hidden = false
        if firstShow {
            firstShow = false
        } else {
             open = false
        }
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        inputKeypadView.hidden = true
    }
    
    
    override  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if open {
            open = false
        }
    }
}

extension CallViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        if viewController == navigationController {
            open = !open
        }
    }
    
    private func changeDisplayTabBarItem() {
        
        navigationController?.tabBarItem.selectedImage = open ?
                                                                UIImage(named: "tab_dial_open~iphone") :
                                                                UIImage(named: "tab_dial_close~iphone")
        tabBarController?.tabBar.layoutIfNeeded()
        
    }
}
