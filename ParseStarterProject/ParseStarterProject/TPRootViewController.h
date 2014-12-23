//
//  ParseStarterProjectViewController.h
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface TPRootViewController : UIViewController <PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate>
@property (strong,nonatomic)UINavigationController* navigationController;

@end
