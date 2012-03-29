//
//  FCChatViewController.m
//  FireChat
//
//  Created by Terry Worona on 12-03-28.
//  Copyright (c) 2012 FireChat. All rights reserved.
//

#import "FCChatViewController.h"

// views
#import "SVProgressHUD.h"

// services
#import "FCService.h"
#import "FCService+Messages.h"

// models
#import "FCMessage.h"

static NSString *CellIdentifier = @"Cell";

@interface FCChatViewController ()

- (void)refreshChat;

@end

@implementation FCChatViewController

@synthesize messages;

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self) {
        self.navigationItem.title = @"FireChat";
		UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed:)];
		self.navigationItem.rightBarButtonItem = refreshButton;
		[refreshButton release];
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self refreshChat]; // refresh chat everytime we bring the app into the fore-ground
}

#pragma mark - Model Helpers

- (void)refreshChat
{
	[SVProgressHUD showWithStatus:@"Syncing..."];
	[[FCService sharedInstance] listMessagesWithCompletion:^(NSArray *newMessages, NSError *error) {
		[SVProgressHUD dismiss];
		if (!error){
			self.messages = newMessages;
			[self.tableView reloadData];
		}
		else{
			[SVProgressHUD showErrorWithStatus:@"Sync Error!"];
		}
	}];
}

#pragma mark - Button Presses

- (void)refreshButtonPressed:(id)sender
{
	[self refreshChat];
}

#pragma mark - Memory Management

- (void)dealloc
{
	[messages release];
	[super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	FCMessage *message = [messages objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];	
	if (!cell) {
		cell = (UITableViewCell*)[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = message.text;
	cell.detailTextLabel.text = message.name;
	return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// nothing to do here
}

@end
