//
//  WebViewController.m
//  Camera
//
//  Created by Cyrilshanway on 2014/11/23.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "WebViewController.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface WebViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    //設定按鈕顏色
    mainVC.sideBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    //設定側邊欄按鈕動作，按下時，顯示側邊欄
    mainVC.sideBarButton.target = self.revealViewController;
    mainVC.sideBarButton.action = @selector(revealToggle:);
    
    //設定手勢
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    //scrollView(background)
    self.backgroundScrollView.contentSize = CGSizeMake(320.0f, 900.0f);
    
    //webView
    NSURL *url = [NSURL URLWithString:@"http://www.dubookreading.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate = self;
    [self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"Raw: %@", request);
    NSString *requestPath = [[request URL] absoluteString];
    NSLog(@"Final: %@", requestPath);
    
    if ([requestPath rangeOfString:@"ServiceLogin"].location != NSNotFound) {
        NSLog(@"Login...");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"登入" delegate:self cancelButtonTitle:@"關閉" otherButtonTitles: nil];
        
        [alert show];
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"開始跑");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"結束");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
