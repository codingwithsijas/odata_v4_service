using itam as db from '../db/schema';

service EmployeeService @(path: '/employees') {

  @odata.draft.enabled
  entity Employees as projection on db.Employee {
    *,
    FirstName || ' ' || LastName as FullName : String @Common.Label : 'Full Name' @readonly
  };
  @readonly entity AssignmentHistory as projection on db.AssignmentHistory;
  @readonly entity Assets as projection on db.Asset;

  @readonly @cds.redirection.target entity Departments as select from db.Department {
    key ID,
        Code,
        Name
  };

  @readonly entity VH_Departments as select from db.Department {
    key ID,
        Code,
        Name
  };

  @readonly @cds.redirection.target entity Locations as select from db.Location {
    key ID,
        Building,
        City,
        Country
  };

  @readonly entity VH_Locations as select from db.Location {
    key ID,
        Building,
        City,
        Country
  };
}
