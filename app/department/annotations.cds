using DepartmentService as service from '../../srv/department-service';

annotate service.Departments with @(
    UI.HeaderInfo : {
        TypeName       : 'Department',
        TypeNamePlural : 'Departments',
        Title          : { $Type : 'UI.DataField', Value : Name },
        Description    : { $Type : 'UI.DataField', Value : Code },
    },
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : Code },
        { $Type : 'UI.DataField', Value : Name },
        { $Type : 'UI.DataField', Value : CostCenter },
        { $Type : 'UI.DataField', Value : Description },
    ],
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : Code },
            { $Type : 'UI.DataField', Value : Name },
            { $Type : 'UI.DataField', Value : Description },
            { $Type : 'UI.DataField', Value : CostCenter },
        ],
    },
    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'idGeneralInfo',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'idEmployees',
            Label  : 'Employees',
            Target : 'employees/@UI.LineItem',
        },
    ],
    UI.SelectionFields : [ Code, Name ],
);

annotate service.Employees with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : EmployeeNumber },
        { $Type : 'UI.DataField', Value : FirstName },
        { $Type : 'UI.DataField', Value : LastName },
        { $Type : 'UI.DataField', Value : JobTitle },
    ],
);
