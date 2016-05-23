//
//  CallViewController.swift
//  Call
//
//  Created by 风起兮 on 16/5/20.
//  Copyright © 2016年 风起兮. All rights reserved.
//

import UIKit

class CallViewController: UITableViewController {
    
    
    private var open = false {
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
        
        inputKeypadView.completion = { [weak self] (inputKeypadView: InputKeypadView, string: String?, operationType: InputKeypadView.Operation) in
        
            func stringSplice(string1: String?,string2: String) ->String {
                return (string1 == nil) ? string2 : (string1! + string2)
            }
            
            switch operationType {
            case .Input:
               self?.indicatorTitleView.title = stringSplice(self?.indicatorTitleView.title,string2: string!)
                self?.changeDisplayBarButtonItem(true)
            case .Paste:
                guard let text = UIPasteboard.generalPasteboard().string else {
                    // attributedTitle attributedMessage NSMutableAttributedString
                    let message = NSMutableAttributedString(string: "找不到号码", attributes: [NSForegroundColorAttributeName:UIColor.orangeColor()])
                    
                    let alertController = UIAlertController(title: nil, message: message.string, preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (_) in
                        
                    }))
                    alertController.view.tintColor = Color.themeColor
                    alertController.setValue(message, forKey: "attributedMessage")
                    self?.presentViewController(alertController, animated: true, completion: nil)
                    return
                }
                self?.indicatorTitleView.title = stringSplice(self?.indicatorTitleView.title,string2: text)
                self?.changeDisplayBarButtonItem(true)
            case .Delete:
               self?.indicatorTitleView.deleteBackward()
               if let _ = self?.indicatorTitleView.title {
                    self?.changeDisplayBarButtonItem(true)
                
               }else {
                    self?.changeDisplayBarButtonItem(false)
                }
                
            case .Dial:
                break
               
            }
      
            
            
        }
        
        return inputKeypadView
        
    }()
    
    
    @IBOutlet weak var indicatorTitleView: IndicatorTitleView!
    
    
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
    
    private func changeDisplayBarButtonItem(hasTitle: Bool) {
        
        if hasTitle {
            
            navigationItem.leftBarButtonItems = [createBarButtonItem(UIImage(named: "back~iphone"), action:  #selector(CallViewController.clearInfo))]
            navigationItem.rightBarButtonItems = [createBarButtonItem(UIImage(named: "groupchat_popup_add~iphone"), action:  #selector(CallViewController.clearInfo))]
            
        }else {
            
            navigationItem.leftBarButtonItems = nil
            navigationItem.rightBarButtonItems = [createBarButtonItem(UIImage(named: "groupchat~iphone"), action:  #selector(CallViewController.clearInfo))]
        }
    }
    
    
    @objc private func clearInfo() {
        changeDisplayBarButtonItem(false)
        self.indicatorTitleView.title = nil
        open = false
    }
    
    
    private func createBarButtonItem(image: UIImage?,action: Selector) ->UIBarButtonItem {
        
      return  UIBarButtonItem(image: image, style: .Done, target: self, action: action)
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
//        if open {
            open = false
//        }
        indicatorTitleView.deleteBackward()
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
