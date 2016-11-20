//
//  WKDelegateController.h
//  WKWebView
//
//  Created by mac on 16/11/20.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WKWebViewJavascriptBridge.h>

@protocol WKDelegate

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface WKDelegateController : UIViewController

@property (weak , nonatomic) id delegate;

@end
