using LocationService as service from '../../srv/location-service';

annotate service.Locations with @(
    UI.HeaderInfo : {
        TypeName       : 'Location',
        TypeNamePlural : 'Locations',
        Title          : { $Type : 'UI.DataField', Value : Building },
        Description    : { $Type : 'UI.DataField', Value : City },
    },
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : Building },
        { $Type : 'UI.DataField', Value : Floor },
        { $Type : 'UI.DataField', Value : Room },
        { $Type : 'UI.DataField', Value : City },
        { $Type : 'UI.DataField', Value : Country },
    ],
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : Building },
            { $Type : 'UI.DataField', Value : Floor },
            { $Type : 'UI.DataField', Value : Room },
            { $Type : 'UI.DataField', Value : City },
            { $Type : 'UI.DataField', Value : Country },
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
    UI.SelectionFields : [ Building, City, Country ],
);

annotate service.Employees with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : EmployeeNumber },
        { $Type : 'UI.DataField', Value : FirstName },
        { $Type : 'UI.DataField', Value : LastName },
        { $Type : 'UI.DataField', Value : JobTitle },
    ],
);
