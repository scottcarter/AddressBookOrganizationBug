

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
 
 
