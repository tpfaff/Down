//
//  TPEventInviteCreationViewController.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/25/14.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "TPEventInviteCreationViewController.h"
#import "TPUniverse.h"
#import "TPLocationViewController.h"
#import "TPPeopleViewController.h"
#import "TPEventObject.h"
#import "TPWhenViewController.h"
#import "TPWhyViewController.h"
#import "Masonry.h"
#import "TPConstants.h"

@implementation TPEventInviteCreationViewController

-(id)init{
    if(self=[super init]){
        self.imageViewLocation=[[UIImageView alloc]init];
        self.imageViewLocation.contentMode=UIViewContentModeScaleAspectFit;
        self.imageViewHostPeople=[[UIImageView alloc]init];
        self.imageViewInvitedPeople=[[UIImageView alloc]init];
        self.viewButtonHolder=[[UIView alloc]init];
        self.butttonDown=[[UIButton alloc]init];
        self.tabBarController=[[UITabBarController alloc]init];
        self.tabBarController.delegate=self;
        TPLocationViewController* locationViewController=[[TPLocationViewController alloc]init];
        locationViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Where" image:nil selectedImage:nil];
        TPPeopleViewController* peopleViewController=[[TPPeopleViewController alloc]init];
        peopleViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Who" image:nil selectedImage:nil];
        
        TPWhenViewController* whenViewController=[[TPWhenViewController alloc]init];
        whenViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"When" image:nil selectedImage:nil];
        
        TPWhyViewController* whyViewController=[[TPWhyViewController alloc]init];
        whyViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Why" image:nil selectedImage:nil];
        
        [self.tabBarController setViewControllers:@[locationViewController,peopleViewController,whenViewController,whyViewController] animated:YES];
        self.event=[[TPEventObject alloc]init];
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
   // [self addChildViewController:self.tabBarController];
    [self addAllViewsAsSubviews];
    

    
//    
//    [self.imageViewLocation mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.height.equalTo(@);
//       // make.top.equalTo([TPUniverse navigationController].view.mas_bottom);
//    }];
    
    BOOL send=YES;
    
    UIBarButtonItem* bbi=[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(showNextViewController)
                          ];
    
    [self.tabBarController tabBarItem].image=[UIImage imageNamed:@"locationIcon"];
    [self navigationItem].title=@"New Invite";
    [self navigationItem].rightBarButtonItem=bbi;
}



-(void)addAllViewsAsSubviews{
    [self.view addSubview:self.viewButtonHolder];
    [self.view addSubview:self.imageViewLocation];
    [self.view addSubview:self.imageViewInvitedPeople];
    [self.view addSubview:self.imageViewHostPeople];
    [self.view addSubview:self.butttonDown];
    [self.view addSubview:self.tabBarController.view];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.viewButtonHolder mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.and.bottom.equalTo(self.view);
//        make.height.equalTo(@90);
//        [self.viewButtonHolder setBackgroundColor:[UIColor lightGrayColor]];
//        
//    }];
//    
//    [self.butttonDown setBackgroundImage:[UIImage imageNamed:@"downLogo"] forState:UIControlStateNormal];
//    
//    [self.butttonDown mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.centerY.equalTo(self.viewButtonHolder);
//        make.height.equalTo(@80);
//        make.width.equalTo(@80);
//    }];

    //154=90+44+20 = button container view height +nagvigation controller height + status bar height
//    long navigationControllerheight=44;
//    long statusBarHeight=20;
    long heightOffset=self.viewButtonHolder.frame.size.height+kTPNavigationAndStatusBarHeight;
    
    NSNumber* oneThirdOfRemaingSpace=[[NSNumber alloc]initWithDouble:((self.view.frame.size.height-heightOffset)/3)];
    
//    [self.imageViewInvitedPeople mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self.view);
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.height.equalTo(oneThirdOfRemaingSpace);
//        [self.imageViewInvitedPeople setBackgroundColor:[UIColor blueColor]];
//    }];
//    
//    [self.imageViewHostPeople mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self.view);
//        make.bottom.equalTo(self.imageViewInvitedPeople.mas_top);
//        make.height.equalTo(oneThirdOfRemaingSpace);
//        [self.imageViewHostPeople setBackgroundColor:[UIColor greenColor]];
//    }];
//   
//    [self.imageViewLocation mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(self.view);
//        make.bottom.equalTo(self.imageViewHostPeople.mas_top);
//        make.height.equalTo(oneThirdOfRemaingSpace);
//        [self.imageViewLocation setBackgroundColor:[UIColor lightGrayColor]];
//        [self.imageViewLocation setImage:[UIImage imageNamed:@"locationIcon"]];
//    }];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    //[self.tabBarController showViewController:viewController sender:nil];

    
    Class lastViewControllerInTabBar = [TPWhyViewController class];
    if([viewController isKindOfClass:lastViewControllerInTabBar]){
        //If it's the last view, show the send button, instead of the next button
        //Later check for completion of invite maybe first
        UIBarButtonItem* bbi=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                          target:self
                                                                          action:@selector(packageAndSendInvite)];
        
        [self navigationItem].title=@"Finish";
        [self navigationItem].rightBarButtonItem=bbi;

    }
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

-(void)showNextViewController{
    if(self.tabBarController.selectedIndex < self.tabBarController.viewControllers.count){
        for (long currentSelectedIndex=0; currentSelectedIndex < self.tabBarController.viewControllers.count; currentSelectedIndex++){
            if(currentSelectedIndex == self.tabBarController.selectedIndex){
                long indexOfNextViewController=currentSelectedIndex+1;
                [self.tabBarController setSelectedIndex:indexOfNextViewController];
                [self tabBarController:self.tabBarController didSelectViewController:[[self.tabBarController viewControllers]objectAtIndex:indexOfNextViewController]];
                return;
            }
        }
    }
}

-(BOOL)packageAndSendInvite{
    BOOL success=[self packageInvite];
  //  if(success){
    [self sendInvite];
  //  }else{
        NSLog(@"Invite object was not created fully, invitation not sent");
 //   }
}

-(BOOL)packageInvite{
    //Build our event object with data from our tabbar view controllers
    NSMutableDictionary* eventDetails=[[NSMutableDictionary alloc]init];
    NSArray* tabBarViewControllers=[self.tabBarController viewControllers];
    
    //where,when,who,why
    NSString* where=[(TPLocationViewController*)[tabBarViewControllers objectAtIndex:0]valueForKey:@"where"];
//    NSString* when;
//    NSArray* who;
//    NSString* why=;
    
    self.event.where=where;
    self.event.who=@[@"tpfaff2"];
    self.event.from=[PFUser currentUser].username;
    
    if([self inviteIsComplete]){
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)inviteIsComplete{
    if(self.event.who && self.event.where && self.event.when && self.event.why && self.event.from){
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)sendInvite{
    PFObject* eventInvitation=[PFObject objectWithClassName:kTPEvent];
    [eventInvitation setObject:self.event.where forKey:kTPEventLocation];
    [eventInvitation setObject:self.event.who forKey:kTPEventInviteList];
    [eventInvitation setObject:self.event.from forKey:kTPEventFrom];
    
    
    [eventInvitation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"Sent invite %@",self.event);
        }else{
            NSLog(@"Failed to send event invite! : Event:%@  \n Error:%@",self.event,error);
        }
    }];
}


@end