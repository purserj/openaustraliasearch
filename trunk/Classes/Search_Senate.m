//
//  Search_Senate.m
//  openaustraliasearch
//
//    Created by James Purser on 24/08/10.
//  Copyright 2010 James Purser
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "Search_Senate.h"
#import "RepObject.h"
#import "RepView.h"


@implementation Search_Senate
@synthesize states;
@synthesize statePicker;
@synthesize stateLabel;
@synthesize repsTable;
@synthesize reps;
@synthesize results;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)serviceController:(id)controller foundSenators:(NSArray *)senators{
	results = [NSMutableArray new];
	reps = [NSMutableArray new];
	
	for (RepObject *senator in senators) {
		NSString *res = [NSString stringWithFormat:@"%@ \n\n %@", senator.fullName, senator.partyName];
		NSLog(@"String - %@",res);
		[results addObject:res];
	}
	NSLog(@"Results Count - %d", [results count]);
	reps = senators;
	[reps retain];
	[results retain];
	[repsTable reloadData];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	states = [[NSArray arrayWithObjects:
			   @"Select your state",
			   @"NSW",
			   @"QLD",
			   @"Vic",
			   @"Tas",
			   @"SA",
			   @"WA",
			   @"ACT",
			   @"NT", nil] retain];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction)selectState:(id)sender{
	[statePicker setHidden:NO];
	NSLog(@"Change State Button is pressed");
}
	
// statePicker setup functions
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [states count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	return [states objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	NSLog(@"Selected Color: %@. Index of selected color: %i", [states objectAtIndex:row], row);
	SenateServiceController *controller = [[SenateServiceController alloc] init];
	[controller setDelegate:self];
	[statePicker setHidden:YES];
	NSString *stateSel;
	if([[states objectAtIndex:row] isEqualToString:@"QLD"]){
		stateLabel.text = @"Senators for QLD";
		stateSel = @"Queensland";
	} else {
		stateLabel.text=[NSString stringWithFormat: @"Senators for %@", [states objectAtIndex:row]];
		stateSel = [states objectAtIndex:row];
	}
	
	
	[controller searchForSenatorsByState:stateSel];
	
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [results count];
	return [results count];
	NSLog(@"Result count - %d", [results count]);
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    cell.text = [results objectAtIndex:indexPath.row]; 
    // Configure the cell...
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	RepObject *repp = (RepObject *)[reps objectAtIndex:indexPath.row];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	RepView *rview = [[RepView alloc] initWithNibName:nil bundle:nil];
	rview.rep = repp;
	NSString *party = repp.partyName;
	NSLog(@"Reps count check - %d", [reps count]);
	NSLog(@"Party name - %@", party);
	NSLog(@"Full Name - %@", repp.fullName);
	NSLog(@"Index - %d", indexPath.row);
	[self presentModalViewController:rview animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [results objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
    return labelSize.height + 20;
}

- (IBAction)goHome:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];	
}

@end
