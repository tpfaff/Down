//
//  TPOutBoxViewController.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/7/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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

    //[TPUniverse navigationController].navigationItem.rightBarButtonItem=bbi;
}

-(void)showEventInviteCreationViewController{
    TPEventInviteCreationViewController* vc=[[TPEventInviteCreationViewController alloc]init];
    [[TPUniverse navigationController]pushViewController:vc animated:YES];
}
@end