# IT Asset Management - Domain Model

This document describes the domain model for the **IT Asset Management** CAP service used throughout the **Mastering Fiori Elements** training series.

The model is designed to cover almost every Fiori Elements feature including:

- List Report
- Object Page
- Value Helps
- Header Facets
- Field Groups
- Line Items
- Actions
- Draft
- Criticality
- Charts
- KPIs
- Navigation
- Compositions
- Associations

---

# Entity Relationship Diagram

```text
                                        +--------------------+
                                        |    Department      |
                                        +--------------------+
                                        | Department ID (PK) |
                                        | Name              |
                                        | Description       |
                                        | Cost Center       |
                                        +--------------------+
                                                  ▲
                                                  │
                                                  │ 1
                                                  │
                                                  │
*                                                 │
+--------------------+                            │
|     Employee       |----------------------------+
+--------------------+
| Employee ID (PK)   |
| Employee Number    |
| First Name         |
| Last Name          |
| Email              |
| Phone              |
| Job Title          |
| Department ID (FK) |
| Location ID (FK)   |
+--------------------+
          ▲
          │ Assigned To
          │ 1
          │
          │
*         │
+-----------------------+
|        Asset          |
+-----------------------+
| Asset ID (PK)         |
| Asset Number          |
| Asset Name            |
| Description           |
| Serial Number         |
| Model                 |
| Manufacturer          |
| Purchase Date         |
| Purchase Cost         |
| Warranty Expiry       |
| Status                |
| Condition             |
| Category ID (FK)      |
| Vendor ID (FK)        |
| Employee ID (FK)      |
| Location ID (FK)      |
+-----------------------+
      ▲        ▲        ▲
      │        │        │
      │        │        │
      │        │        │
+--------------+  +----------------+  +----------------+
|Asset Category|  |    Vendor      |  |    Location    |
+--------------+  +----------------+  +----------------+
| Category ID  |  | Vendor ID      |  | Location ID    |
| Code         |  | Vendor Code    |  | Building       |
| Name         |  | Name           |  | Floor          |
| Description  |  | Contact Person |  | Room           |
+--------------+  | Email          |  | City           |
                  | Phone          |  | Country        |
                  +----------------+  +----------------+

          │
          │ 1
          │
          │
*         │
+---------------------------+
|    Maintenance Record     |
+---------------------------+
| Maintenance ID (PK)       |
| Asset ID (FK)             |
| Maintenance Date          |
| Type                      |
| Vendor ID (FK)            |
| Cost                      |
| Next Service Date         |
| Remarks                   |
+---------------------------+

          │
          │ 1
          │
          │
*         │
+---------------------------+
|   Assignment History      |
+---------------------------+
| History ID (PK)           |
| Asset ID (FK)             |
| Employee ID (FK)          |
| Assigned Date             |
| Returned Date             |
| Remarks                   |
+---------------------------+

          │
          │ 1
          │
          │
*         │
+---------------------------+
|      Attachment           |
+---------------------------+
| Attachment ID (PK)        |
| Asset ID (FK)             |
| File Name                 |
| Media Type                |
| URL                       |
+---------------------------+
```

---

# Entity Details

## 1. Asset

The **Asset** entity is the root business object and serves as the primary Object Page in the application.

### Properties

| Property | Description |
|----------|-------------|
| Asset ID | Primary Key |
| Asset Number | Business Identifier |
| Asset Name | Display name |
| Description | Description of the asset |
| Serial Number | Manufacturer serial number |
| Model | Device model |
| Manufacturer | Manufacturer name |
| Purchase Date | Purchase date |
| Purchase Cost | Original purchase cost |
| Warranty Expiry | Warranty expiration date |
| Status | Available, Assigned, Maintenance, Retired, Lost |
| Condition | Excellent, Good, Fair, Damaged |

### Associations

- Asset belongs to one **Asset Category**
- Asset belongs to one **Vendor**
- Asset is assigned to one **Employee**
- Asset belongs to one **Location**

### Child Collections

- Maintenance Records
- Assignment History
- Attachments

---

## 2. Employee

Represents employees within the organization.

### Properties

- Employee ID
- Employee Number
- First Name
- Last Name
- Email
- Phone
- Job Title

### Associations

- Employee belongs to one Department
- Employee belongs to one Location
- Employee can own many Assets
- Employee appears in many Assignment History records

---

## 3. Department

Represents organizational departments.

### Properties

- Department ID
- Department Code
- Department Name
- Description
- Cost Center

### Associations

- Department has many Employees

---

## 4. Location

Represents office locations.

### Properties

- Location ID
- Building
- Floor
- Room
- City
- Country

### Associations

- Location has many Employees
- Location has many Assets

---

## 5. Asset Category

Represents classifications of assets.

### Properties

- Category ID
- Category Code
- Category Name
- Description
- Depreciation Period

### Example Categories

- Laptop
- Desktop
- Mobile Phone
- Monitor
- Docking Station
- Printer
- Server
- Network Switch
- Keyboard
- Mouse

### Associations

- Asset Category has many Assets

---

## 6. Vendor

Represents suppliers of IT assets.

### Properties

- Vendor ID
- Vendor Code
- Vendor Name
- Contact Person
- Email
- Phone
- Website

### Associations

- Vendor supplies many Assets
- Vendor performs many Maintenance Records

---

## 7. Maintenance Record

Represents the maintenance history of an asset.

### Properties

- Maintenance ID
- Maintenance Date
- Maintenance Type
- Cost
- Next Service Date
- Remarks

### Associations

- Maintenance Record belongs to one Asset
- Maintenance Record references one Vendor

---

## 8. Assignment History

Tracks every assignment of an asset throughout its lifecycle.

### Properties

- History ID
- Assigned Date
- Returned Date
- Remarks

### Associations

- Assignment History belongs to one Asset
- Assignment History belongs to one Employee

Unlike the current assignment stored on the Asset entity, this table preserves the complete assignment history.

---

## 9. Attachment

Stores supporting documents for an asset.

### Properties

- Attachment ID
- File Name
- Media Type
- URL

### Associations

- Attachment belongs to one Asset

### Example Attachments

- Purchase Invoice
- Warranty Certificate
- Service Report
- User Manual

---

# Relationship Summary

| Parent Entity | Child Entity | Cardinality | Description |
|---------------|-------------|-------------|-------------|
| Department | Employee | 1 : N | One department contains many employees |
| Location | Employee | 1 : N | Employees work at one location |
| Location | Asset | 1 : N | Assets are located at one location |
| Employee | Asset | 1 : N | Employee can currently own multiple assets |
| Asset Category | Asset | 1 : N | Assets belong to one category |
| Vendor | Asset | 1 : N | Vendor supplies many assets |
| Asset | Maintenance Record | 1 : N | Asset maintenance history |
| Vendor | Maintenance Record | 1 : N | Vendor performs maintenance |
| Asset | Assignment History | 1 : N | Historical assignments |
| Employee | Assignment History | 1 : N | Employee assignment records |
| Asset | Attachment | 1 : N | Asset supporting documents |

---

# Suggested Status Values

- Available
- Assigned
- Under Maintenance
- Retired
- Lost

---

# Suggested Condition Values

- Excellent
- Good
- Fair
- Damaged

---

# Planned Business Actions

The following actions can be added gradually throughout the training:

- Assign Asset
- Return Asset
- Transfer Asset
- Send for Maintenance
- Complete Maintenance
- Extend Warranty
- Mark as Lost
- Recover Asset
- Retire Asset
- Dispose Asset

---

# Fiori Elements Mapping

| Entity | Purpose |
|---------|---------|
| Asset | Root Object Page |
| Employee | Value Help, Navigation |
| Department | Value Help |
| Vendor | Value Help |
| Asset Category | Value Help |
| Location | Value Help |
| Maintenance Record | Object Page Table |
| Assignment History | Object Page Table |
| Attachment | Object Page Table |

---

# Future Enhancements

The same domain model can later be extended to demonstrate:

- Draft Handling
- Bound Actions
- Unbound Actions
- Side Effects
- Header Facets
- Field Groups
- Criticality
- Dynamic Expressions
- KPIs
- Analytical List Page
- Charts
- Intent-Based Navigation
- Flexible Programming Model Extensions

This model is intentionally designed to support the entire **Mastering Fiori Elements** training series without requiring a change in the underlying business domain.