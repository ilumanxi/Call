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
    
    private let inputKeypadViewHeight: CGFloat = 250.0
    
    private lazy var inputKeypadView: InputKeypadView =  {
        [weak self] in
        let inputKeypadView = InputKeypadView.loadFromXIB()
        inputKeypadView.translatesAutoresizingMaskIntoConstraints = false
        
        inputKeypadView.completion = { [weak self] (inputKeypadView: InputKeypadView, string: String?, operationType: InputKeypadView.Operation) in
        
            func stringSplice(string1: String?,string2: String) ->String {
                return (string1 == nil) ? string2 : (string1! + string2)
            }
            
            func show(title: String?,message: String) {
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                    
                }))
                alertController.view.tintColor = Color.themeColor
                
                // attributedTitle attributedMessage NSMutableAttributedString
                let attributeMessage = NSMutableAttributedString(string: message, attributes: [NSAttributedStringKey.foregroundColor:UIColor.orange])
                if let _ = title {
                    let attributeTitle = NSMutableAttributedString(string: title!, attributes: [NSAttributedStringKey.foregroundColor:Color.themeColor])
                    alertController.setValue(attributeTitle, forKey: "attributedTitle")
                }
                alertController.setValue(attributeMessage, forKey: "attributedMessage")
                self?.present(alertController, animated: true, completion: nil)
            }
            
            switch operationType {
            case .input:
                self?.indicatorTitleView.title = stringSplice(string1: self?.indicatorTitleView.title,string2: string!)
                self?.changeDisplayBarButtonItem(true)
            case .paste:
                guard let text = UIPasteboard.general.string else {
                    show(title: nil, message: "找不到号码")
                    return
                }
                self?.indicatorTitleView.title = stringSplice(string1: self?.indicatorTitleView.title,string2: text)
                self?.changeDisplayBarButtonItem(true)
            case .delete:
               self?.indicatorTitleView.deleteBackward()
               if let _ = self?.indicatorTitleView.title {
                    self?.changeDisplayBarButtonItem(true)
                
               }else {
                    self?.changeDisplayBarButtonItem(false)
                }
                
            case .dial:
                guard let phone = self?.indicatorTitleView.title else {
                    show(title: "温馨提示", message: "请您输入号码")
                    return
                }
                
                guard let url = URL(string: "tel:"+phone) else {
                    show(title: "温馨提示", message: "请您检查号码")
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                    self?.webView.loadRequest(URLRequest(url: url))
                } else {
                    show(title: "温馨提示", message: "请您使用iPhone拨打电话")
                }
            }
        }
        return inputKeypadView
        
    }()
    
    // call
    lazy var webView: UIWebView =  {
        [weak self] in
        let webView = UIWebView()
        self?.view.addSubview(webView)
        return webView
    }()
    
    @IBOutlet weak var indicatorTitleView: IndicatorTitleView! {
        didSet {
            indicatorTitleView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        }
    }
    
    
    private var inputKeypadViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate  = self
       
        configInputKeypad()
        
    }
    
    private func configInputKeypad () {
        let tabBar = tabBarController!.tabBar
        let tabBarControllerView = tabBarController!.view
        tabBarControllerView?.insertSubview(inputKeypadView, belowSubview: tabBar)
        
        
        inputKeypadView.leftAnchor.constraint(equalTo: (tabBarControllerView?.leftAnchor)!).isActive = true
        inputKeypadView.rightAnchor.constraint(equalTo: (tabBarControllerView?.rightAnchor)!).isActive = true
        inputKeypadViewBottomConstraint = inputKeypadView.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
        inputKeypadViewBottomConstraint.isActive = true
        inputKeypadView.heightAnchor.constraint(equalToConstant: inputKeypadViewHeight).isActive = true
        
//        let views = ["inputKeypadView":inputKeypadView,"tabBar":tabBar]
//        let inputKeypadViewWidthConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[inputKeypadView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
//        inputKeypadViewBottomConstraint = NSLayoutConstraint(item: inputKeypadView, attribute: .Bottom, relatedBy: .Equal, toItem: tabBar, attribute: .Top, multiplier: 1.0, constant: 0)
//        let inputKeypadViewHeightConstraint = NSLayoutConstraint(item: inputKeypadView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 250)
//        tabBarControllerView.addConstraints(inputKeypadViewWidthConstraint)
//        tabBarControllerView.addConstraint(inputKeypadViewBottomConstraint)
//        tabBarControllerView.addConstraint(inputKeypadViewHeightConstraint)
    }
    
    private func inputKeypadAnimate(_ up: Bool) {
        
        inputKeypadViewBottomConstraint.constant = up ? 0 : inputKeypadViewHeight
        
        UIView.animate(withDuration: 0.25) {
            
            self.tabBarController?.view.layoutIfNeeded()
        }
        
    }
    
    private func changeDisplayBarButtonItem(_ hasTitle: Bool) {
        
        if hasTitle {
            
            navigationItem.leftBarButtonItems = [createBarButtonItem(image: UIImage(named: "back~iphone"), action:  #selector(CallViewController.clearInfo))]
            navigationItem.rightBarButtonItems = [createBarButtonItem(image: UIImage(named: "groupchat_popup_add~iphone"), action:  #selector(CallViewController.clearInfo))]
            
        }else {
            
            navigationItem.leftBarButtonItems = nil
            navigationItem.rightBarButtonItems = [createBarButtonItem(image: UIImage(named: "groupchat~iphone"), action:  #selector(CallViewController.clearInfo))]
        }
    }
    
    
    @objc private func clearInfo() {
        changeDisplayBarButtonItem(false)
        self.indicatorTitleView.title = nil
        open = false
    }
    
    
    private func createBarButtonItem(image: UIImage?,action: Selector) ->UIBarButtonItem {
        
        return  UIBarButtonItem(image: image, style: .done, target: self, action: action)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inputKeypadView.isHidden = false
        if firstShow {
            firstShow = false
        } else {
             open = false
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        inputKeypadView.isHidden = true
    }
    
    
    override  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if open {
            open = false
//        }
        indicatorTitleView.deleteBackward()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [UITableViewRowAction(style: .default, title: "删除", handler: { (rowAction, indexPath) in
            
        })]
    }
}

extension CallViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
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
