//
//  TPWhyViewController.h
//  Down
//
//  Created by Tyler Pfaff on 1/4/15.
//
//

#import <UIKit/UIKit.h>
@protocol TPWhyViewControllerDelegate;

@interface TPWhyViewController : UIViewController
@property (strong,nonatomic) UITextField* messageField;
@property (weak,nonatomic)id <TPWhyViewControllerDelegate> delegate;
@end

@protocol TPWhyViewControllerDelegate <NSObject>

-(void)TPWhyViewController:(TPWhyViewController*) viewController textWasEntered:(NSString*)text;

@end