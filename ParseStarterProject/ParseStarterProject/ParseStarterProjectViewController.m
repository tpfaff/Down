//
//  ParseStarterProjectViewController.m
//  ParseStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import "ParseStarterProjectViewController.h"

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "TPSplashScreenViewController.h"
#import "TPMailBoxViewController.h"


@interface ParseStarterProjectViewController(){}

//@property (strong,nonatomic)TPSplashScreenViewController* splashScreenViewController;
//@property (strong,nonatomic)UINavigationController* rootNavigationController;
//@property (nonatomic) BOOL showingSplashScreen;
@end


@implementation ParseStarterProjectViewController

#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)viewDidLoad {
    [super viewDidLoad];
    //TDP logOut
    //[PFUser logOut];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(![PFUser currentUser].username){ //no user logged in
        PFLogInViewController* logInViewController=[[PFLogInViewController alloc]init];
        [logInViewController setDelegate:self];
        
        //Create the signup view controller
        PFSignUpViewController* signUpViewController=[[PFSignUpViewController alloc]init];
        [signUpViewController setDelegate:self];
        
        [logInViewController setSignUpController:signUpViewController];
        
        //Present the log in view controller
        [self.navigationController pushViewController:logInViewController animated:YES];
        [self presentViewController:logInViewController animated:YES completion:NULL];
        
    }else{
        NSLog(@"User %@ is logged in",[PFUser currentUser]);
        [NSTimer scheduledTimerWithTimeInterval:2
                                         target:self
                                       selector:@selector(presentMailBoxViewController)
                                       userInfo:nil
                                        repeats:NO];
    }

   }

-(BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password{
    if(username && password && username.length!=0 && password.length!=0){
        return YES;
    }else{
        [[[UIAlertView alloc]initWithTitle:@"Missing Information"
                                   message:@"Make sure you fill out all of the information!"
                                  delegate:nil
                         cancelButtonTitle:@"Got it"
                         otherButtonTitles:nil] show];
        
        return NO; //Interrupt login process
    }
    
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
 
    //[self popViewControllerAnimated:YES];z
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismissed view controller");
    //    [self pushSplashScreenViewController];
    }];
    
    
   }

-(void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error{
    NSLog(@"Failed to log in! Error: %@",error);
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)pushSplashScreenViewController{
//    self.splashScreenViewController=[[TPSplashScreenViewController alloc]init];
//    [self.splashScreenViewController view];
//    [self presentViewController:self.splashScreenViewController animated:YES completion:NULL];
//}

-(void)presentMailBoxViewController{
    TPMailBoxViewController* mailBoxViewController=[[TPMailBoxViewController alloc]initWithNibName:@"TPMailBoxViewController" bundle:nil];
    [self presentViewController:mailBoxViewController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
