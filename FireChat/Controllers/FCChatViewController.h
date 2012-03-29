//
//  FCChatViewController.h
//  FireChat
//
//  Created by Terry Worona on 12-03-28.
//  Copyright (c) 2012 FireChat. All rights reserved.
//

#import <UIKit/UIKit.h>

// views
#import "UIInputToolbar.h"
#import "FCWebView.h"

@interface FCChatViewController : UIViewController{
	UIInputToolbar *inputToolbar;
	UITableView *tableView;
	
	FCWebView *webView;
    BOOL firstLoad;
	
@private
    BOOL keyboardIsVisible;
}

@property (nonatomic, retain) NSArray* messages;
@property (nonatomic, retain) UIInputToolbar *inputToolbar;

@end
