//
//  ViewController.m
//  WKWebView
//
//  Created by mac on 16/11/20.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "ViewController.h"
#import <WKWebViewJavascriptBridge.h>
#import "WKDelegateController.h"
#import <Masonry.h>



@interface ViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, WKDelegate> {

    WKWebView *_webView;
    WKUserContentController *_userContentController;

}

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userContentController = [[WKUserContentController alloc] init];
    
    // 配置环境
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = _userContentController;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    [self.view addSubview:_webView];
    
    //注册方法
    WKDelegateController * delegateController = [[WKDelegateController alloc]init];
    delegateController.delegate = self;
    [_userContentController addScriptMessageHandler:delegateController  name:@"sayhello"];
    
    // [_userContentController addScriptMessageHandler:self  name:@"sayhello"];//注册一个name为sayhello的js方法
    
    
    // 适配
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    // 代理
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    
    // 加载URL
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://nba.sina.cn/?vt=4&pos=10"]]];
    
}



#pragma mark - WKNavigationDelegate
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);   // http://nba.sina.cn/?vt=4&pos=10
                                                                // http://r.dmp.sina.cn/cm/sinaads_ck_wap.html
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

// 开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    NSLog(@"开始加载");     // 开始加载
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);        // http://nba.sina.cn/?vt=4&pos=10
                                                                        // http://r.dmp.sina.cn/cm/sinaads_ck_wap.html
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}


// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
 
    NSLog(@"内容开始加载");       // 内容开始加载
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
 
    NSLog(@"页面加载完毕");       // 内容加载完毕
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
 
    NSLog(@"页面加载失败");
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
 
    NSLog(@"收到服务器跳转请求");
    
}









#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    return [[WKWebView alloc]init];
    
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{

    completionHandler(@"http");
    
}

// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    completionHandler(YES);
    
}

// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    NSLog(@"%@",message);
    completionHandler();
    
}






#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"name:%@\n body:%@\n frameInfo:%@\n",message.name,message.body,message.frameInfo);
    
}

















#warning 这里没有调用，导致内存泄露
- (void)dealloc{
    //这里需要注意，前面增加过的方法一定要remove掉。
    [_userContentController removeScriptMessageHandlerForName:@"sayhello"];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
