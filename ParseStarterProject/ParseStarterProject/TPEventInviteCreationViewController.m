//
//  TPEventInviteCreationViewController.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/25/14.
//
//

#import <Foundation/Foundation.h>
#import "TPEventInviteCreationViewController.h"
#import "Masonry.h"

@implementation TPEventInviteCreationViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
   // [self.view addSubview:self.mockInviteView];
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view.superview);
//    }];
//    
//    [self.mockInviteView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view.superview);
//    }];
    [self navigationItem].title=@"New Invite";
}

@end