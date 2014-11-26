//
//  BookViewController.h
//  Camera
//
//  Created by Cyrilshanway on 2014/11/26.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString *owner;
@property (nonatomic, strong) NSString *email;

//判斷
@property (nonatomic, strong) NSDictionary *oneBookInfoDictionary;//
@property (nonatomic, strong) NSMutableDictionary *oneOwnerAllBooks;//isbn/oneBookInfoDictionary
@property (nonatomic, strong) NSMutableArray *ISBNbookArray;

@end
