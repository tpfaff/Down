//
//  TPPeopleViewController.m
//  Down
//
//  Created by Tyler Pfaff on 12/28/14.
//
//

#import "TPPeopleViewController.h"
#import "TPConstants.h"
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
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
