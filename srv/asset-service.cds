using itam as db from '../db/schema';

service AssetService @(path: '/assets') {

  @odata.draft.enabled
  entity Assets as projection on db.Asset actions {
    action assignAsset(employeeID : UUID, locationID : UUID) returns Assets;
    action returnAsset()                                      returns Assets;
    action sendForMaintenance(vendorID : UUID)                returns Assets;
    action completeMaintenance()                              returns Assets;
    action markAsLost()                                       returns Assets;
    action retireAsset()                                      returns Assets;
  };

  // Compositions — navigable from Assets
  entity MaintenanceRecords  as projection on db.MaintenanceRecord;
  entity AssignmentHistories as projection on db.AssignmentHistory;
  entity Attachments         as projection on db.Attachment;

  // Value helps — read-only, no write
  @readonly entity VH_Employees as select from db.Employee {
    key ID,
        EmployeeNumber,
        FirstName,
        LastName,
        JobTitle
  };

  @readonly entity VH_Locations as select from db.Location {
    key ID,
        Building,
        City,
        Country
  };

  @readonly entity VH_Vendors as select from db.Vendor {
    key ID,
        Code,
        Name,
        ContactPerson
  };

  @readonly entity VH_Categories as select from db.AssetCategory {
    key ID,
        Code,
        Name
  };
}
