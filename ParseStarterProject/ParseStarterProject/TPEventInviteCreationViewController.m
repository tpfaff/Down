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
#import "TPAddFriendsTableViewController.h"

@implementation TPEventInviteCreationViewController

-(id)init{
    if(self=[super init]){
        self.imageViewLocation=[[UIImageView alloc]init];
        self.imageViewLocation.contentMode=UIViewContentModeScaleAspectFit;
        self.imageViewHostPeople=[[UIImageView alloc]init];
        self.imageViewInvitedPeople=[[UIImageView alloc]init];
        self.viewButtonHolder=[[UIView alloc]init];
        self.butttonDown=[[UIButton alloc]init];
        
        self.locationViewController=[[TPLocationViewController alloc]init];
        self.locationViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Where" image:nil selectedImage:nil];
        self.locationViewController.delegate=self;
        
        self.peopleViewController=[[TPPeopleViewController alloc]init];
        self.peopleViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Who" image:nil selectedImage:nil];
        
        TPWhenViewController* whenViewController=[[TPWhenViewController alloc]init];
        whenViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"When" image:nil selectedImage:nil];
        whenViewController.delegate=self;
        
        TPWhyViewController* whyViewController=[[TPWhyViewController alloc]init];
        whyViewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"Why" image:nil selectedImage:nil];
        whyViewController.delegate=self;
        
        [self setViewControllers:@[self.locationViewController,whenViewController,whyViewController,self.peopleViewController] animated:YES];
      //  [[TPUniverse navigationController]setViewControllers:@[self.locationViewController,peopleViewController,whenViewController,whyViewController]];
        self.event=[[TPEventObject alloc]init];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
   // [self.navigationController pushViewController:self.locationViewController animated:YES];
    }



-(void)addAllViewsAsSubviews{
    [self.view addSubview:self.imageViewLocation];
    [self.view addSubview:self.imageViewInvitedPeople];
    [self.view addSubview:self.imageViewHostPeople];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addAllViewsAsSubviews];
    UIView* nextButtonHolder=[[UIView alloc]init];
    [nextButtonHolder setBackgroundColor:[UIColor lightGrayColor]];
    
    UIButton* nextButton=[[UIButton alloc]init];
    [nextButton setImage:[UIImage imageNamed:@"buttonNext"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(showNextViewController) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nextButtonHolder];
//    [self.view addSubview:nextButton];
//    
//    
//    [nextButtonHolder mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.view.mas_width);
//        make.height.equalTo(@75);
//        make.bottom.equalTo(self.view.mas_bottom);
//    }];
//    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerX.equalTo(nextButtonHolder.mas_centerX);
//        make.centerY.equalTo(nextButtonHolder.mas_centerY);
//        make.height.equalTo(nextButtonHolder.mas_height);
//        make.width.equalTo(nextButtonHolder.mas_height);
//    }];
    
    
    BOOL send=YES;
    
    UIBarButtonItem* bbi=[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(showNextViewController)
                          ];
    
    [self tabBarItem].image=[UIImage imageNamed:@"locationIcon"];
    [self navigationItem].title=@"New Invite";
    [self navigationItem].rightBarButtonItem=bbi;

    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    //[self.tabBarController showViewController:viewController sender:nil];

    
    Class lastViewControllerInTabBar = [[[tabBarController viewControllers]lastObject]class];
    Class peopleViewController= [TPPeopleViewController class];
    
    if([viewController isKindOfClass:peopleViewController]){
        UIBarButtonItem* bbi=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddFriendViewController)];
        [self navigationItem].rightBarButtonItem=bbi;
    }
    
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
    if(self.selectedIndex < self.viewControllers.count){
        for (long currentSelectedIndex=0; currentSelectedIndex < self.viewControllers.count; currentSelectedIndex++){
            if(currentSelectedIndex == self.selectedIndex){
                long indexOfNextViewController=currentSelectedIndex+1;
                [self setSelectedIndex:indexOfNextViewController];
//                [self.navigationController pushViewController:[[self viewControllers]objectAtIndex:indexOfNextViewController]] animated:YES];
                //[[TPUniverse navigationController]pushViewController:[[self viewControllers]objectAtIndex:indexOfNextViewController] animated:YES];
                [self tabBarController:self didSelectViewController:[[self viewControllers]objectAtIndex:indexOfNextViewController]];
                return;
            }
        }
    }
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
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
//    NSMutableDictionary* eventDetails=[[NSMutableDictionary alloc]init];
//    NSArray* tabBarViewControllers=[self viewControllers];
//    
//    
////    self.event.location=where;
////    self.event.who=@[@"tpfaff2"];
////    self.event.from=[PFUser currentUser].username;
//    
//    if([self inviteIsComplete]){
//        return YES;
//    }else{
//        return NO;
//    }
    return YES;
}

-(BOOL)inviteIsComplete{
    if(self.event.who && self.event.location && self.event.when && self.event.why && self.event.from){
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)sendInvite{
    PFObject* eventInvitation=[PFObject objectWithClassName:kTPEvent];
    PFObject* location=[PFObject objectWithClassName:kTPEventLocation];
    [location setObject:self.event.location.name forKey:kTPLocationName];
    NSNumber* longitude=[NSNumber numberWithDouble:self.event.location.longitude];
    NSNumber* lattitude=[NSNumber numberWithDouble:self.event.location.latitude];
    
    [location setObject:lattitude forKey:kTPLocationLatitude];
    [location setObject:longitude forKey:kTPLocationLongitude];
    
    self.event.from=[[PFUser currentUser]username];
    
    //[eventInvitation setObject:self.event.location forKey:kTPEventLocation];
    self.event.who=[self.peopleViewController getSelectedUsernames];
    [eventInvitation setObject:self.event.who forKey:kTPEventInviteList];
    [eventInvitation setObject:self.event.from forKey:kTPEventFrom];
    [eventInvitation setObject:self.event.why forKey:kTPEventMessage];
    [eventInvitation setObject:location forKey:kTPEventLocation];
    
    
    [eventInvitation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"Sent invite %@",self.event);
            UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Sent!" message:self.event.description delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            
            /// !!!: Users can't modify other users, need to use cloud code to do this. bleh.
            
//            for(PFUser* invitedUser in self.event.who){
//                [invitedUser setObject:eventInvitation forKey:@"invitedTo"];
//                [invitedUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                    if(succeeded){
//                        NSLog(@"Saved event to user");
//                    }else{
//                        NSLog(@"Failed to save event to uesr with error : %@",error);
//                    }
//                }];
//                NSString* userID=[invitedUser objectForKey:@"objectId"];
//                PFQuery* userQuery=[[PFQuery alloc]initWithClassName:kTPParseUser];
//                [userQuery getObjectInBackgroundWithId:userID block:^(PFObject *object, NSError *error) {
//                    <#code#>
//                }];
            
        }else{
            NSLog(@"Failed to send event invite! : Event:%@  \n Error:%@",self.event,error);
        }
    }];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TPLocationViewControllerDelegate
-(void)TPLocationViewController:(TPLocationViewController *)viewController didSelectLocation:(TPLocation *)location{
    self.event.location=location;
}

#pragma mark - TPWhenViewControllerDelegate
-(void)TPWhenViewController:(TPWhenViewController *)viewController didSelectDate:(NSDate *)date{
    self.event.when=date;
}

#pragma mark -TPWhyViewControllerDeleage

-(void)TPWhyViewController:(TPWhyViewController *)viewController textWasEntered:(NSString *)text{
    self.event.why=text;
}
@end