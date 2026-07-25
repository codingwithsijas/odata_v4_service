# OData V4 service with batch support

This project is a oData application which uses oData V4 protocal which can be consumed by any oData compatible applications.

The service contains below entities.

1. Person
2. Trip
3. Locations
4. Photos

Below are rules or condition:

- A Person can have many friends, each friend is again a person. Hence friends is a navigation of Personwith multiple cardinatlity.
- A Person can travel to different locations. A each Trip is a travel of a person. trips is a navigation of Person with with multiple cardinatlity.
- Each Trip can have multiple locations. locations is a navigation with with multiple cardinatlity.
- Photos are taken at a trip and particular location, Hence photos is a navigation of Trip.

## Architecture:

Language: CAP

Output: xml and json based on http header accept: application/json or application/xml

Initial data: to be supplied by csv.
