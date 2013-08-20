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
    NSDictionary *_dict;
}
@end

@implementation infoSIViewController

@synthesize webGallery = _webGallery;
@synthesize titleLbl;
@synthesize descrBox;
@synthesize BigTitleLbl;

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
   // NSString *fullURL = @"http://bglive.net/SeeIt/slider/slider.php?image_id=1";
    
    
//    NSString *fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://bglive.net/SeeIt/slider/slider.php?image_id=%@", key]];
//    NSURL *url = [NSURL URLWithString:fullURL];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [_webGallery loadRequest:requestObj];
    
    titleLbl.text = [_dict objectForKey:@"placeName"];
    descrBox.text = [_dict objectForKey:@"description"];
    BigTitleLbl.text = [_dict objectForKey:@"placeName"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadInfoForKey:(NSString *)key
{
    //connection to JSON database
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://bglive.net/SeeIt/data/getAllPlaces.php?place_id=%@", key]];
   
    
    NSString *fullURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://bglive.net/SeeIt/slider/slider.php?image_id=%@", key]];
    NSURL *urlgallery = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:urlgallery];
    [_webGallery loadRequest:requestObj];
    
    
    NSStringEncoding *encoding = NULL;
    NSError *error2;
    
    
    NSString *connectDB = [[NSString alloc] initWithContentsOfURL:url usedEncoding: encoding error: &error2]; // Pulls the URL
    
 	NSData *jsonData = [connectDB dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    NSError *error = nil;
    
    
 	_dict = [[[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error] objectForKey:@"places"] objectAtIndex:0];
    
}

@end
