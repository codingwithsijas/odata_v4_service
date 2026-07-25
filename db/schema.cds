namespace travel;

using { managed } from '@sap/cds/common';

entity Person : managed {
  key UserName  : String(50);
      FirstName : String(100);
      LastName  : String(100);
      Emails    : many String(200);
      friends   : Association to many Friends on friends.person = $self;
      trips     : Composition of many Trip on trips.person = $self;
}

// Self-referencing many-to-many for friends
entity Friends {
  key person  : Association to Person;
  key friend  : Association to Person;
}

type TripStatus : String(20) enum { active = 'active'; cancelled = 'cancelled'; }

entity Trip {
  key TripId      : Integer;
      Name        : String(100);
      Budget      : Decimal(15,2);
      Description : String(500);
      Tags        : many String(50);
      StartsAt    : DateTime;
      EndsAt      : DateTime;
      Status      : TripStatus default 'active';
      person      : Association to Person;
      locations   : Composition of many Location on locations.trip = $self;
      photos      : Composition of many Photo   on photos.trip   = $self;
}

entity Location {
  key Id          : Integer;
      Name        : String(200);
      Address     : String(300);
      City        : String(100);
      CountryRegion : String(100);
      trip        : Association to Trip;
}

entity Photo {
  key Id     : Integer;
      Name   : String(200);
      trip   : Association to Trip;
}
