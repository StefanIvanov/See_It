//
//  infoSIViewController.h
//  SeeIt
//
//  Created by Atanas on 8/7/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface infoSIViewController : UIViewController

- (void)loadInfoForKey:(NSString *)key;
@property (strong, nonatomic) IBOutlet UIWebView *webGallery;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UITextView *descrBox;

@end
