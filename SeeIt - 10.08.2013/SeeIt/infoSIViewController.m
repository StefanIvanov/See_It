//
//  infoSIViewController.m
//  SeeIt
//
//  Created by Atanas on 8/7/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import "infoSIViewController.h"

@interface infoSIViewController ()
{
    NSString *_key;
}
@end

@implementation infoSIViewController

@synthesize webGallery = _webGallery;
@synthesize titleLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Gallery View
    _webGallery.scrollView.scrollEnabled = NO;
    _webGallery.scrollView.bounces = NO;
    _webGallery.scalesPageToFit = NO;
    _webGallery.multipleTouchEnabled = NO;
    NSString *fullURL = @"http://bglive.net/SeeIt/slider/";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webGallery loadRequest:requestObj];
    
    titleLbl.text = _key;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInfoForKey:(NSString *)key
{
    _key = key;
}

@end
