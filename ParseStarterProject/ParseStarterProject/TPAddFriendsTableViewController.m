//
//  TPAddFriendsTableViewController.m
//  Down
//
//  Created by Tyler Pfaff on 1/12/15.
//
//

#import "TPAddFriendsTableViewController.h"
#import "TPConstants.h"
#import <Parse/Parse.h>
#import <Masonry/Masonry.h>

@interface TPAddFriendsTableViewController ()
@end

@implementation TPAddFriendsTableViewController

NSString* nameQuery;
NSMutableArray* dataSource;
static NSString* reuseIdentifier;

-(id)init{
    if(self=[super init]){
        self.searchBar=[[UISearchBar alloc]init];
        self.searchBar.delegate=self;
        reuseIdentifier=@"friendCell";
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    self.tableView.tableHeaderView=self.searchBar;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.searchBar).with.offset(self.searchBar.mas_height);
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text=[[dataSource objectAtIndex:indexPath.row]objectForKey:kTPUserName];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    NSString* friendUsername=[[selectedCell textLabel]text];
    [self addFriend:friendUsername];
}

-(void)addFriend:(NSString*)username{
    PFUser* currentUser=[PFUser currentUser];
    NSMutableArray* friendsList=[currentUser objectForKey:kTPFriendsList];
    if(!friendsList){
        friendsList=[[NSMutableArray alloc]init];
    }
    
    if(![friendsList containsObject:username]){
        [friendsList addObject:username];
        [currentUser setObject:friendsList forKey:kTPFriendsList];
        [currentUser saveInBackground];
    }
    
    for(PFUser* user in dataSource){
        if([user.username isEqualToString:username]){
            [dataSource removeObject:user];
            break;
        }
    }
    [self.tableView reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)searchForName:(NSString*)name{
    PFQuery* query=[[PFQuery alloc]initWithClassName:@"_User"];
    
    // !!!: This search is slow for large datasets
    [query whereKey:kTPUserName containsString:name];
    [query whereKey:kTPUserName notContainedIn:[[PFUser currentUser] objectForKey:kTPFriendsList]];
    //NSArray* friendsList=[[PFUser currentUser]objectForKey:kTPFriendsList];
    //[query whereKey:kTPFriendsList notContainedIn:@[friendsList]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            [self updateTableAfterSearchWithResults:objects];
    }];
}

-(void)updateTableAfterSearchWithResults:(NSArray*)results{
    dataSource=[results mutableCopy];
    [self.tableView reloadData];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self searchForName:searchText];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    dataSource=nil;
}

@end
