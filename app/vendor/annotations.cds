using VendorService as service from '../../srv/vendor-service';

annotate service.Vendors with @(
    UI.HeaderInfo : {
        TypeName       : 'Vendor',
        TypeNamePlural : 'Vendors',
        Title          : { $Type : 'UI.DataField', Value : Name },
        Description    : { $Type : 'UI.DataField', Value : Code },
    },
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : Code },
        { $Type : 'UI.DataField', Value : Name },
        { $Type : 'UI.DataField', Value : ContactPerson },
        { $Type : 'UI.DataField', Value : Email },
        { $Type : 'UI.DataField', Value : Phone },
        { $Type : 'UI.DataField', Value : Website },
    ],
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : Code },
            { $Type : 'UI.DataField', Value : Name },
            { $Type : 'UI.DataField', Value : ContactPerson },
            { $Type : 'UI.DataField', Value : Email },
            { $Type : 'UI.DataField', Value : Phone },
            { $Type : 'UI.DataField', Value : Website },
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
            ID     : 'idAssets',
            Label  : 'Assets',
            Target : 'assets/@UI.LineItem',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'idMaintenanceRecords',
            Label  : 'Maintenance Records',
            Target : 'maintenanceRecords/@UI.LineItem',
        },
    ],
    UI.SelectionFields : [ Code, Name ],
);

annotate service.Assets with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : AssetNumber },
        { $Type : 'UI.DataField', Value : Name },
        { $Type : 'UI.DataField', Value : Status },
        { $Type : 'UI.DataField', Value : Condition },
    ],
);

annotate service.MaintenanceRecords with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : MaintenanceDate },
        { $Type : 'UI.DataField', Value : Type },
        { $Type : 'UI.DataField', Value : Cost },
        { $Type : 'UI.DataField', Value : NextServiceDate },
    ],
);
