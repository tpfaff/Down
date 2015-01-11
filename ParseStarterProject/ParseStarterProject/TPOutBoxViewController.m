//
//  TPOutBoxViewController.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/7/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TPOutBoxViewController.h"
#import "TPUniverse.h"
#import "TPEventInviteCreationViewController.h"

@interface TPOutBoxViewController(){}

@end
@implementation TPOutBoxViewController

-(id)init{
    if(self=[super init]){
       
    }
  return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //UINavigationItem* navigationItem=[[UINavigationItem alloc]initWithTitle:@"Sent Invites"];
   // [TPUniverse navigationController].navigationItem=navigationItem;
    UIBarButtonItem* bbi=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showEventInviteCreationViewController)];
    [self navigationItem].rightBarButtonItem=bbi;
    [self navigationItem].title=@"Sent Invites";
    
    NSString* me=[PFUser currentUser].username;
    PFQuery* messageQuery=[[PFQuery alloc]initWithClassName:@"Message"];
    [messageQuery whereKey:@"for" equalTo:me];
    
    [messageQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(object){
            NSLog(@"I got your message : %@",[object objectForKey:@"tuna"]);
        }else{
            NSLog(@"Failed to find object : %@",error);
        }
    }];

    //[TPUniverse navigationController].navigationItem.rightBarButtonItem=bbi;
}

-(void)showEventInviteCreationViewController{
    
    PFObject* sampleData=[PFObject objectWithClassName:@"Message" dictionary:@{@"tuna":@"sandwich",@"for":@"tpfaff2"}];
    [sampleData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"Succeeded");
        }else{
            NSLog(@"error : %@",error);
        }
    }];

    TPEventInviteCreationViewController* vc=[[TPEventInviteCreationViewController alloc]init];
    //vc.hidesBottomBarWhenPushed=YES;
    [[TPUniverse navigationController]pushViewController:vc animated:YES];
}
@end