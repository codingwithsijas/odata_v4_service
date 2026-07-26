using CategoryService as service from '../../srv/category-service';

annotate service.Categories with @(
    UI.HeaderInfo : {
        TypeName       : 'Asset Category',
        TypeNamePlural : 'Asset Categories',
        Title          : { $Type : 'UI.DataField', Value : Name },
        Description    : { $Type : 'UI.DataField', Value : Code },
    },
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : Code },
        { $Type : 'UI.DataField', Value : Name },
        { $Type : 'UI.DataField', Value : DepreciationPeriod },
        { $Type : 'UI.DataField', Value : Description },
    ],
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : Code },
            { $Type : 'UI.DataField', Value : Name },
            { $Type : 'UI.DataField', Value : Description },
            { $Type : 'UI.DataField', Value : DepreciationPeriod },
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
