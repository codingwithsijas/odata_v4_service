using itam as db from '../db/schema';

service LocationService @(path: '/locations') {

  @odata.draft.enabled
  entity Locations as select from db.Location {
    key ID,
        Building,
        Floor,
        Room,
        City,
        Country,
        employees
  };

  @readonly @cds.redirection.target entity Employees as projection on db.Employee {
    key ID,
        EmployeeNumber,
        FirstName,
        LastName,
        JobTitle,
        location
  };

  @readonly entity VH_Employees as select from db.Employee {
    key ID,
        EmployeeNumber,
        FirstName,
        LastName,
        JobTitle
  };
}
