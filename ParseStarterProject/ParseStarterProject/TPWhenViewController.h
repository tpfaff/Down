//
//  TPWhenViewController.h
//  Down
//
//  Created by Tyler Pfaff on 1/3/15.
//
//


#ifndef Down_TPWhenViewController_h
#define Down_TPWhenViewController_h

#import <UIKit/UIKit.h>

@protocol TPWhenViewControllerDelegate;


@interface TPWhenViewController : UIViewController
@property (strong,nonatomic) UIDatePicker* timePicker;
@property (strong,nonatomic) UIDatePicker* datePicker;
@property (nonatomic, weak) id <TPWhenViewControllerDelegate> delegate;

@end

@protocol TPWhenViewControllerDelegate <NSObject>

-(void)TPWhenViewController:(TPWhenViewController*)viewController didSelectDate:(NSDate*)date;

@end

#endif