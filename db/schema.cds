namespace itam;

using {managed} from '@sap/cds/common';

// ─── Lookup / Reference entities ───────────────────────────────────────────

entity Department {
  key ID          : UUID          @Common.Label : 'ID';
      Code        : String(20)    @Common.Label : 'Code';
      Name        : String(100)   @Common.Label : 'Name';
      Description : String(500)   @Common.Label : 'Description';
      CostCenter  : String(20)    @Common.Label : 'Cost Center';
      employees   : Association to many Employee
                      on employees.department = $self;
}

entity Location {
  key ID       : UUID         @Common.Label : 'ID';
      Building : String(100)  @Common.Label : 'Building';
      Floor    : String(20)   @Common.Label : 'Floor';
      Room     : String(20)   @Common.Label : 'Room';
      City     : String(100)  @Common.Label : 'City';
      Country  : String(100)  @Common.Label : 'Country';
      employees : Association to many Employee
                    on employees.location = $self;
      assets    : Association to many Asset
                    on assets.location = $self;
}

entity AssetCategory {
  key ID                 : UUID       @Common.Label : 'ID';
      Code               : String(20)  @Common.Label : 'Code';
      Name               : String(100) @Common.Label : 'Name';
      Description        : String(500) @Common.Label : 'Description';
      DepreciationPeriod : Integer      @Common.Label : 'Depreciation Period'; // months
      assets             : Association to many Asset
                             on assets.category = $self;
}

entity Vendor {
  key ID            : UUID          @Common.Label : 'ID';
      Code          : String(20)    @Common.Label : 'Code';
      Name          : String(100)   @Common.Label : 'Name';
      ContactPerson : String(100)   @Common.Label : 'Contact Person';
      Email         : String(200)   @Common.Label : 'Email';
      Phone         : String(30)    @Common.Label : 'Phone';
      Website       : String(200)   @Common.Label : 'Website';
      assets        : Association to many Asset
                        on assets.vendor = $self;
      maintenanceRecords : Association to many MaintenanceRecord
                             on maintenanceRecords.vendor = $self;
}

// ─── Core entities ──────────────────────────────────────────────────────────

entity Employee : managed {
  key ID             : UUID          @Common.Label : 'ID';
      EmployeeNumber : String(20)    @Common.Label : 'Employee Number';
      FirstName      : String(100)   @Common.Label : 'First Name';
      LastName       : String(100)   @Common.Label : 'Last Name';
      Email          : String(200)   @Common.Label : 'Email';
      Phone          : String(30)    @Common.Label : 'Phone';
      JobTitle       : String(100)   @Common.Label : 'Job Title';
      department     : Association to Department  @Common.Label : 'Department';
      location       : Association to Location    @Common.Label : 'Location';
      assets         : Association to many Asset
                         on assets.assignedTo = $self;
      assignmentHistory : Association to many AssignmentHistory
                            on assignmentHistory.employee = $self;
}

type AssetStatus : String(20) enum {
  Available   = 'Available';
  Assigned    = 'Assigned';
  Maintenance = 'Maintenance';
  Retired     = 'Retired';
  Lost        = 'Lost';
}

type AssetCondition : String(20) enum {
  Excellent = 'Excellent';
  Good      = 'Good';
  Fair      = 'Fair';
  Damaged   = 'Damaged';
}

entity Asset : managed {
  key ID             : UUID               @Common.Label : 'ID';
      AssetNumber    : String(30)          @Common.Label : 'Asset Number';
      Name           : String(200)         @Common.Label : 'Name';
      Description    : String(1000)        @Common.Label : 'Description';
      SerialNumber   : String(100)         @Common.Label : 'Serial Number';
      Model          : String(100)         @Common.Label : 'Model';
      Manufacturer   : String(100)         @Common.Label : 'Manufacturer';
      PurchaseDate   : Date                @Common.Label : 'Purchase Date';
      PurchaseCost   : Decimal(15, 2)      @Common.Label : 'Purchase Cost';
      WarrantyExpiry : Date                @Common.Label : 'Warranty Expiry';
      Status         : AssetStatus         @Common.Label : 'Status'    default 'Available';
      Condition      : AssetCondition      @Common.Label : 'Condition' default 'Good';
      category       : Association to AssetCategory  @Common.Label : 'Category';
      vendor         : Association to Vendor          @Common.Label : 'Vendor';
      assignedTo     : Association to Employee        @Common.Label : 'Assigned To';
      location       : Association to Location        @Common.Label : 'Location';
      maintenanceRecords : Composition of many MaintenanceRecord
                             on maintenanceRecords.asset = $self;
      assignmentHistory  : Composition of many AssignmentHistory
                             on assignmentHistory.asset = $self;
      attachments        : Composition of many Attachment
                             on attachments.asset = $self;
}

type MaintenanceType : String(30) enum {
  Preventive  = 'Preventive';
  Corrective  = 'Corrective';
  Inspection  = 'Inspection';
  Calibration = 'Calibration';
}

entity MaintenanceRecord : managed {
  key ID              : UUID              @Common.Label : 'ID';
      asset           : Association to Asset    @Common.Label : 'Asset';
      MaintenanceDate : Date                    @Common.Label : 'Maintenance Date';
      Type            : MaintenanceType         @Common.Label : 'Type';
      vendor          : Association to Vendor   @Common.Label : 'Vendor';
      Cost            : Decimal(15, 2)          @Common.Label : 'Cost';
      NextServiceDate : Date                    @Common.Label : 'Next Service Date';
      Remarks         : String(1000)            @Common.Label : 'Remarks';
}

entity AssignmentHistory : managed {
  key ID           : UUID                       @Common.Label : 'ID';
      asset        : Association to Asset       @Common.Label : 'Asset';
      employee     : Association to Employee    @Common.Label : 'Employee';
      AssignedDate : Date                       @Common.Label : 'Assigned Date';
      ReturnedDate : Date                       @Common.Label : 'Returned Date';
      Remarks      : String(500)                @Common.Label : 'Remarks';
}

entity Attachment {
  key ID        : UUID          @Common.Label : 'ID';
      asset     : Association to Asset  @Common.Label : 'Asset';
      FileName  : String(200)   @Common.Label : 'File Name';
      MediaType : String(100)   @Common.Label : 'Media Type';
      URL       : String(500)   @Common.Label : 'URL';
}
