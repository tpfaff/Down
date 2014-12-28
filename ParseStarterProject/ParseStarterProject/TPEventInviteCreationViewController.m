//
//  TPEventInviteCreationViewController.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/25/14.
//
//

#import <Foundation/Foundation.h>
#import "TPEventInviteCreationViewController.h"
#import "TPUniverse.h"
#import "Masonry.h"

@implementation TPEventInviteCreationViewController

-(id)init{
    if(self=[super init]){
        self.imageViewLocation=[[UIImageView alloc]init];
        self.imageViewHostPeople=[[UIImageView alloc]init];
        self.imageViewInvitedPeople=[[UIImageView alloc]init];
        self.viewButtonHolder=[[UIView alloc]init];
        self.butttonDown=[[UIButton alloc]init];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self addAllViewsAsSubviews];
    

    
//    
//    [self.imageViewLocation mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.height.equalTo(@);
//       // make.top.equalTo([TPUniverse navigationController].view.mas_bottom);
//    }];

    [self navigationItem].title=@"New Invite";
}



-(void)addAllViewsAsSubviews{
    [self.view addSubview:self.viewButtonHolder];
    [self.view addSubview:self.imageViewLocation];
    [self.view addSubview:self.imageViewInvitedPeople];
    [self.view addSubview:self.imageViewHostPeople];
    [self.view addSubview:self.butttonDown];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.viewButtonHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.equalTo(@90);
        [self.viewButtonHolder setBackgroundColor:[UIColor lightGrayColor]];
        
    }];
    
    [self.butttonDown setBackgroundImage:[UIImage imageNamed:@"downLogo"] forState:UIControlStateNormal];
    
    [self.butttonDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.viewButtonHolder);
        make.height.equalTo(@80);
        make.width.equalTo(@80);
    }];
    
    double height=self.viewButtonHolder.frame.size.height;
    //154=90+44+20 = button container view height +nagvigation controller height + status bar height
    NSNumber* oneThirdOfRemaingSpace=[[NSNumber alloc]initWithDouble:((self.view.frame.size.height-154)/3)];
    
    [self.imageViewInvitedPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.viewButtonHolder.mas_top);
        make.height.equalTo(oneThirdOfRemaingSpace);
        [self.imageViewInvitedPeople setBackgroundColor:[UIColor blueColor]];
    }];
    
    [self.imageViewHostPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.imageViewInvitedPeople.mas_top);
        make.height.equalTo(oneThirdOfRemaingSpace);
        [self.imageViewHostPeople setBackgroundColor:[UIColor greenColor]];
    }];
   
    [self.imageViewLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.imageViewHostPeople.mas_top);
        make.height.equalTo(oneThirdOfRemaingSpace);
        [self.imageViewLocation setBackgroundColor:[UIColor redColor]];
    }];
}
@end