//
//  WebVC.m
//  RedditTop50
//
//  Created by Carlos Peralta on 17/11/15.
//  Copyright © 2015 Carlos Peralta. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Reddit large Article image";
}

-(void)viewWillAppear:(BOOL)animated{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlImage]]];

}




@end
