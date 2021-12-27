//
//  ServiceVC.swift
//  SureShow
//
//  Created by Dharmani Apps on 21/09/21.
//

import UIKit
import Foundation
import WebKit

class ServiceVC : BaseVC {
    
    @IBOutlet weak var serviceWebView: WKWebView!
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnBack(_ sender: Any) {
        self.pop()
    }
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: SettingWebLinks.termsAndConditions)
        let request = NSURLRequest(url: url! as URL)
        serviceWebView.navigationDelegate = self
        serviceWebView.load(request as URLRequest)
//        headingLbl.text = linkLblText
        // Do any additional setup after loading the view.
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
extension ServiceVC:WKNavigationDelegate{

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    AFWrapperClass.svprogressHudShow(title: "Loading...", view: self)
  }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    AFWrapperClass.svprogressHudDismiss(view: self)
  }

    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        Alert.present(
            title: AppAlertTitle.appName.rawValue,
            message: error.localizedDescription,
            actions: .ok(handler: {
            }),
            from: self
        )
      }
}
