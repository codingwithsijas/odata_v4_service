using itam as db from '../db/schema';

service VendorService @(path: '/vendors') {

  @odata.draft.enabled
  entity Vendors as projection on db.Vendor {
    key ID,
        Code,
        Name,
        ContactPerson,
        Email,
        Phone,
        Website,
        assets,
        maintenanceRecords
  };

  @readonly @cds.redirection.target entity Assets as projection on db.Asset {
    key ID,
        AssetNumber,
        Name,
        Status,
        Condition,
        vendor
  };

  @readonly @cds.redirection.target entity MaintenanceRecords as projection on db.MaintenanceRecord {
    key ID,
        asset,
        MaintenanceDate,
        Type,
        Cost,
        NextServiceDate,
        vendor
  };

  @readonly entity VH_Assets as select from db.Asset {
    key ID,
        AssetNumber,
        Name,
        Status
  };
}
