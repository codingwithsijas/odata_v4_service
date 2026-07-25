using travel as db from '../db/schema';

service TravelService @(path: '/travel') {

  @odata.draft.enabled
  @cds.redirection.target
  entity People    as projection on db.Person;

  entity Friends   as projection on db.Friends;

  entity Trips     as projection on db.Trip actions {
    // Set trip status to 'cancelled'
    action cancelTrip()  returns Trips;
    // Re-enable a previously cancelled trip
    action resumeTrip()  returns Trips;
  };

  @cds.redirection.target
  entity Locations as projection on db.Location;
  entity Photos    as projection on db.Photo;

  // Value help entities — read-only, no draft
  @readonly
  entity VH_People as select from db.Person {
    key UserName,
        FirstName,
        LastName
  };

  @readonly
  entity VH_Locations as select from db.Location {
    key Id,
        Name,
        City,
        CountryRegion
  };
}
