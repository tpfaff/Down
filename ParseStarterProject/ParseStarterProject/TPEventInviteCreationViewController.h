//
//  TPEventInviteCreationViewController.h
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/25/14.
//
//
#import <UIKit/UIKit.h>
#import "TPEventObject.h"
#import "TPLocationViewController.h"
#import "TPWhenViewController.h"

#ifndef ParseStarterProject_TPEventInviteCreationViewController_h
#define ParseStarterProject_TPEventInviteCreationViewController_h

@interface TPEventInviteCreationViewController : UIViewController <UITabBarControllerDelegate,TPLocationViewControllerDelegate,TPWhenViewControllerDelegate>
@property (strong,nonatomic) UIImageView* imageViewLocation;
@property (strong,nonatomic) UIImageView* imageViewHostPeople;
@property (strong,nonatomic) UIImageView* imageViewInvitedPeople;
@property (strong,nonatomic) UIView*      viewButtonHolder;
@property (strong,nonatomic) UIButton*    butttonDown;
@property (strong,nonatomic) UITabBarController* tabBarController;
@property (strong,nonatomic) TPEventObject* event;
@end

#endif
