Detailed description of the services.

1. Employee Service
  - CRUD operation of Employee Entity.
  - Entity such as Asset, AssignmentHistory, Location, Department entites can't be modified.
  - location and department association can be modified. i.e., location of Employee can be changed, department can be changed.
  - Asset assignment and AssignmentHistory will not be done in this service
2. Department Service
  - CRUD operation on Department Entity.
  - Employee entity cannot be modified. It is a value help.
  - employees association cannot be modified, i.e, this will changed in Employee Service.
3. Similar service for Location, AssetCategory, Vendor.
4. Asset service: 
  1. CRUD of Asset.
  2. Assignment of Employee to asset.
  3. No core entities like Employee, Location, Department, Vendor, AssetCategory is modified in this service. They will be having their own service and app.
  4. maintenanceRecords, AssignmentHistory are not created by user, based on the asset assignment, they are logged.
