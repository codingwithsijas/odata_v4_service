using EmployeeService as service from '../../srv/employee-service';

annotate service.Employees with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: EmployeeNumber
            },
            {
                $Type: 'UI.DataField',
                Value: FirstName
            },
            {
                $Type: 'UI.DataField',
                Value: LastName
            },
            {
                $Type: 'UI.DataField',
                Value: Email
            },
            {
                $Type: 'UI.DataField',
                Value: Phone
            },
            {
                $Type: 'UI.DataField',
                Value: JobTitle
            },
            {
                $Type: 'UI.DataField',
                Value: department_ID
            },
            {
                $Type: 'UI.DataField',
                Value: location_ID
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'idGeneralInfo',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'idAssignmentHistory',
            Label : 'Assignment History',
            Target: 'assignmentHistory/@UI.LineItem',
        }
    ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: EmployeeNumber
        },
        {
            $Type: 'UI.DataField',
            Value: FirstName
        },
        {
            $Type: 'UI.DataField',
            Value: LastName
        },
        {
            $Type: 'UI.DataField',
            Value: Email
        },
        {
            $Type: 'UI.DataField',
            Value: Phone
        },
        {
            $Type: 'UI.DataField',
            Value: JobTitle
        },
        {
            $Type: 'UI.DataField',
            Value: department_ID
        },
        {
            $Type: 'UI.DataField',
            Value: location_ID
        },
        {
            $Type     : 'UI.DataField',
            Value     : FullName,
            @UI.Hidden: true
        }
    ],
    UI.SelectionFields           : [
        department_ID,
        location_ID
    ],
    UI.HeaderInfo                : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Employee',
        TypeNamePlural: 'Employees',
        Title         : {
            $Type: 'UI.DataField',
            Value: FullName
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: EmployeeNumber
        },
    }
);

annotate service.Employees with {
    department @(
        Common.Text           : department.Name,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Departments',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: department_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Name',
                },
            ],
        }
    );
    location   @(
        Common.Text           : location.Building,
        Common.TextArrangement: #TextOnly,
        Common.ValueList      : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Locations',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: location_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Building',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'City',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Country',
                },
            ],
        }
    );

    FullName   @UI.HiddenFilter

};

annotate service.Departments with {
    ID @Common.ExternalID: Code
};

annotate service.Locations with {
    ID @UI.Hidden: true
};

annotate service.AssignmentHistory with @(

UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: ID,
        Label: 'Asset',
    },
    {
        $Type: 'UI.DataField',
        Value: AssignedDate
    },
    {
        $Type: 'UI.DataField',
        Value: ReturnedDate
    },
    {
        $Type: 'UI.DataField',
        Value: Remarks
    },
]);

annotate service.AssignmentHistory with {
    ID @(
        Common.Text: asset.Name,
        Common.TextArrangement: #TextOnly
    );
};