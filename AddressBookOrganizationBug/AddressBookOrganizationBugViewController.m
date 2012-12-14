//
//  AddressBookOrganizationBugViewController.m
//  AddressBookOrganizationBug
//
//  Created by Scott Carter on 12/13/12.
//  Copyright (c) 2012 Scott Carter. All rights reserved.
//

/*
 
 This project is intended to demonstrate a memory leak when setting
 kABPersonKindProperty to kABPersonKindOrganization, in conjunction with 
 setting the kABPersonOrganizationProperty property.
 
 The leak occurs with a deployment target = 5.1 and profiled using the
 iPhone 5.1 Simulator.
 
 The leak does not occur when using the iPhone 6.0 Simulator.
 
 More environment details
 ------------------------
 Xcode 4.5.2 (4G2008a)
 
 Mac OS X Lion 10.7.5 (11G63)
 
 
 */


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
    
    
    
    // Set the record value for kABPersonKindProperty - a property of type kABIntegerPropertyType
    //
    // Note:  If we use kABPersonKindPerson instead of kABPersonKindOrganization we don't leak.
    //
    if(!ABRecordSetValue(record_cf, kABPersonKindProperty, kABPersonKindOrganization, error)) {
        NSLog(@"Error with ABRecordSetValue for kABPersonKindProperty property ");
    }
    
    
    
    // Set the record value for kABPersonOrganizationProperty - a property of type kABStringPropertyType
    //
    // Note: The following code causes a string leak, but only if we had previously set the kABPersonKindProperty
    //       to kABPersonKindOrganization.   Not setting kABPersonKindProperty, or setting it to
    //       kABPersonKindPerson will NOT cause the string leak.
    
    // Name of the organization we will add to the record
    CFStringRef strValue_cf = CFStringCreateWithCString (kCFAllocatorDefault,"ABC Corp.", kCFStringEncodingUTF8);
    
    if(!ABRecordSetValue(record_cf, kABPersonOrganizationProperty, strValue_cf, error)) {
        NSLog(@"Error with ABRecordSetValue for kABPersonOrganizationProperty property");
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
