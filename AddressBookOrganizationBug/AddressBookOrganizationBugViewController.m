//
//  AddressBookOrganizationBugViewController.m
//  AddressBookOrganizationBug
//
//  Created by Scott Carter on 12/13/12.
//  Copyright (c) 2012 Scott Carter. All rights reserved.
//

#import "AddressBookOrganizationBugViewController.h"
#import <AddressBook/AddressBook.h>

@interface AddressBookOrganizationBugViewController ()

@end

@implementation AddressBookOrganizationBugViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CFErrorRef *error = NULL;
    
    // Create our reference to the Address Book database
    ABAddressBookRef addressBook_cf = ABAddressBookCreate();
    
    // Create a new Person record
    ABRecordRef record_cf = ABPersonCreate();
    
    
    
    // Name of the organization we will add to the record
    CFStringRef strValue_cf = CFStringCreateWithCString (kCFAllocatorDefault,"ABC Corp.", kCFStringEncodingUTF8);
    
    // Set the record value for kABPersonOrganizationProperty property
    if(!ABRecordSetValue(record_cf, kABPersonOrganizationProperty, strValue_cf, error)) {
        NSLog(@"Error with ABRecordSetValue");
    }
    
    // Release our string value
    if(strValue_cf){
        CFRelease(strValue_cf);
    }
    
    
    
    // Add record to Address Book
    if(!ABAddressBookAddRecord(addressBook_cf, record_cf, error)){
        NSLog(@"Error trying to call ABAddressBookAddRecord");
    }
    
    // Release our Person record
    if(record_cf){
        CFRelease(record_cf);
    }
    
    
    
    // Save our changes to the Address Book database
    if(!ABAddressBookSave(addressBook_cf,error)) {
        NSLog(@"Error trying to call ABAddressBookSave");
    }
    
    // Release our reference to the Address Book database
    if(addressBook_cf){
        CFRelease(addressBook_cf);
    }
    
    NSLog(@"Done");
    
}


@end
