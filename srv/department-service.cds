using itam as db from '../db/schema';

service DepartmentService @(path: '/departments') {

  @odata.draft.enabled
  entity Departments as select from db.Department {
    key ID,
        Code,
        Name,
        Description,
        CostCenter,
        employees
  };

  @readonly @cds.redirection.target entity Employees as projection on db.Employee {
    key ID,
        EmployeeNumber,
        FirstName,
        LastName,
        JobTitle,
        department
  };

  @readonly entity VH_Employees as select from db.Employee {
    key ID,
        EmployeeNumber,
        FirstName,
        LastName,
        JobTitle
  };
}
