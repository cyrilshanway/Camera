//
//  OneBookViewController.m
//  Camera
//
//  Created by Cyrilshanway on 2014/12/1.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "OneBookViewController.h"
#import "Book.h"
#import <Parse/Parse.h>
#import "SWRevealViewController.h"
#import "MainViewController.h"

@interface OneBookViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@property (weak, nonatomic) IBOutlet UITextView *bookDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OneBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    //設定按鈕顏色
    mainVC.sideBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    //設定側邊欄按鈕動作，按下時，顯示側邊欄
    mainVC.sideBarButton.target = self.revealViewController;
    mainVC.sideBarButton.action = @selector(revealToggle:);
    
    //設定手勢
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//回傳每個區段要顯示多少列
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
//不要做任何運算(畫面會卡住，運算，create)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *requestIdentifier = @"HelloCell";
    static NSString *requestIdentifier2 = @"HelloCell2";
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:requestIdentifier];
            
            //value2-textLabel和detailLabel會連在一起
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:requestIdentifier];
            
            cell.detailTextLabel.font = [UIFont fontWithName:@"apfino" size:14.0f];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:requestIdentifier2];
            
            //value2-textLabel和detailLabel會連在一起
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:requestIdentifier2];
            //cell.textLabel.textColor = [UIColor whiteColor];
            
            cell.textLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:244.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
            //預設白色，調整tableView的顏色-11/24
            cell.backgroundColor = [UIColor clearColor];
            //字型
            //cell.textLabel.font = [UIFont systemFontOfSize:20.f];//20.f
            cell.textLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:20.0f];//20.f
            
            
            //
            //cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
            cell.detailTextLabel.font = [UIFont fontWithName:@"apfino" size:14.0f];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
            break;
            
        default:
            break;
    }
    
    
    
    /*
     cell.textLabel.text = _myBook.bookPublished;
     cell.textLabel.text = _myBook.pageNum;
     cell.textLabel.text = _myBook.ISBNNum;
     */
    //cell.textLabel.text = myArray[indexPath.row];
    
        
    return cell;
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
