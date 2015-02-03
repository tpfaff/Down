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
#import "TPConstants.h"
#import "Masonry/Masonry.h"

@interface TPOutBoxViewController(){}
@property (strong,nonatomic) NSArray* sentInvites;
@end
@implementation TPOutBoxViewController

static NSString* cellID=@"cell";

-(id)init{
    if(self=[super init]){
        self.tableView=[[UITableView alloc]init];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
    }
  return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //UINavigationItem* navigationItem=[[UINavigationItem alloc]initWithTitle:@"Sent Invites"];
   // [TPUniverse navigationController].navigationItem=navigationItem;
    UIBarButtonItem* bbi=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showEventInviteCreationViewController)];
    [self navigationItem].rightBarButtonItem=bbi;
    [self navigationItem].title=@"Sent Invites";
    
    NSString* me=[PFUser currentUser].username;
    PFQuery* query=[PFQuery queryWithClassName:KTPParseEvent];
    [query whereKey:@"From" equalTo:me];
    ///!!!: this is synchronous
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            self.sentInvites=objects;
            [self.tableView reloadData];
        }else{
            NSLog(@"Error: %@",error);
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

#pragma mark - TableView delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[self.tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell=[[UITableViewCell alloc]init];
    }
    
    PFObject* locationID=[[self.sentInvites objectAtIndex:indexPath.row]objectForKey:kTPEventLocation];
    PFQuery* locationQuery=[[PFQuery alloc]initWithClassName:kTPEventLocation];
    [locationQuery getObjectInBackgroundWithId:locationID.objectId block:^(PFObject *object, NSError *error) {
        if([object objectForKey:@"Name"]){
            NSString* locationName=[object objectForKey:@"Name"];
            cell.textLabel.text=locationName;
            
        }else{
            cell.textLabel.text=@"No name";
        }

    }];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sentInvites.count;
    
}


@end