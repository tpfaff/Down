//
//  TPPeopleViewController.m
//  Down
//
//  Created by Tyler Pfaff on 12/28/14.
//
//

#import "TPPeopleViewController.h"
#import "TPConstants.h"
#import "TPAddFriendsTableViewController.h"
#import <Parse/Parse.h>
#import "Masonry/Masonry.h"

@interface TPPeopleViewController ()
@property (strong,nonatomic) NSArray* friendsList;
@end

@implementation TPPeopleViewController


-(id)init{
    if(self=[super init]){
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        self.tableView.allowsMultipleSelection=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView* headerView=[[UIView alloc]init];
    UIButton* addFriendButton=[UIButton buttonWithType:UIButtonTypeContactAdd];
    [addFriendButton addTarget:self action:@selector(showAddFriendViewController) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:addFriendButton];
    [headerView setBackgroundColor:[UIColor grayColor]];
    [headerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, addFriendButton.frame.size.height+15)];
    //[self.view addSubview:headerView];
    self.tableView.tableHeaderView=headerView;
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.and.trailing.equalTo(self.view);
//        make.height.equalTo(@75);
//    }];
    
    [addFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo([self navigationController].view.mas_bottom);
//    }];
    
    //This makes it so the nav bar doesn't cover up the top of the table view.
//    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
//        self.edgesForExtendedLayout = UIRectEdgeNone;
    // self.navigationItem.title=@"Friends";

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getFriendsList];
  //e  [self.view setFrame:CGRectMake(0, kTPNavigationAndStatusBarHeight, self.view.frame.size.width, self.view.frame.size.height-kTPNavigationAndStatusBarHeight)];

}

- (void) viewDidLayoutSubviews {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"friendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    
    cell.textLabel.text=[self.friendsList objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendsList.count;
}

-(void)getFriendsList{
    self.friendsList=[[PFUser currentUser]objectForKey:kTPFriendsList];
    [self.tableView reloadData];
    
}

-(NSArray*)getSelectedUsernames{
    NSArray* selectedIndexPaths=[self.tableView indexPathsForSelectedRows];
    NSMutableArray* selectedUsernames=[[NSMutableArray alloc]init];
    
    for(NSIndexPath* path in selectedIndexPaths){
        UITableViewCell* cell=[self.tableView cellForRowAtIndexPath:path];
        NSString* selectedUserName=cell.textLabel.text;
        PFQuery* query=[PFUser query];
        [query whereKey:kTPUserName equalTo:selectedUserName];
        
        ///!!!: this is a synchronous call :(
        PFUser* selectedUser=(PFUser*)[query getFirstObject];
        [selectedUsernames addObject:selectedUser];
    }
    
    return selectedUsernames;
}

-(void)showAddFriendViewController{
    TPAddFriendsTableViewController* vc=[[TPAddFriendsTableViewController alloc]init];
    [self.navigationController showViewController:vc sender:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
