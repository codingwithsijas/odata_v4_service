using itam as db from '../db/schema';

service CategoryService @(path: '/categories') {

  @odata.draft.enabled
  entity Categories as projection on db.AssetCategory {
    key ID,
        Code,
        Name,
        Description,
        DepreciationPeriod,
        assets
  };

  @readonly @cds.redirection.target entity Assets as projection on db.Asset {
    key ID,
        AssetNumber,
        Name,
        Status,
        Condition,
        category
  };

  @readonly entity VH_Assets as select from db.Asset {
    key ID,
        AssetNumber,
        Name,
        Status
  };
}
