# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Microsoft Dynamics 365 Business Central AL language extension** for Sigma Cylinders providing custom SCM functionality: transfer order management, purchase order enhancements, warehouse operations, and production order integration.

- Language: AL (Application Language for Business Central)
- Version: 27.0.0.41 (Application version 26.0.0.0, Runtime 15.0)
- Publisher: RJ Group Publisher
- ID Range: 76100–76199
- Dependency: TransfersFromProduction (InventSolutions v1.0.0.8)
- Feature: `NoImplicitWith`

## Build and Deployment

There is no explicit build command. The AL Language Extension in VS Code compiles automatically on save; errors appear in the Problems panel.

**To publish to sandbox (`.vscode/launch.json`):**
- Press `F5` or use "Microsoft cloud sandbox" debug configuration
- Target: Sandbox environment named `"Sandbox"`
- `schemaUpdateMode: ForceSync` — schema changes are force-synced on each deploy
- Increment `"version"` in `app.json` before publishing a new release

## Source Code Architecture

### Directory Structure

```
src/
├── codeunit/        # Business logic and event subscribers
├── enum/            # Custom enumerations
├── page/            # Custom pages
├── pageextension/   # Extensions to standard BC pages (44 total)
├── table/           # Custom tables
├── tableextension/  # Extensions to standard BC tables (32 total)
└── permissionset/   # Role-based access control
```

### Custom Tables

| Object | Name | Purpose |
|--------|------|---------|
| Tab76100 | SIGMA Lookup - V3 | Reference data (WEEKNO, Vendor Category) |
| Tab76101 | Parent Transfer Order | Header for multi-location transfer grouping; cascades dimensions to child lines via `UpdateAllLineDim()` |
| Tab76102 | Parent Transfer Order Line | Component-level transfer detail; tracks `Fully Processed` / `Partially Processed` status |
| Tab76103 | Item Subcategory Code | Multi-level item classification (Category 2–6) beyond standard BC item categories |

### Core Codeunit: Sigma Modif. Func and Subs (Cod76100)

The main event subscriber hub. All hooks are `local procedure` event subscribers — no base object modification:

1. **Document Attachment events** — extends `Document Attachment Mgmt` to support attachments on `Warehouse Shipment Header` and `Warehouse Receipt Header` (not supported by default).

2. **Transfer Order posting events** — `OnBeforeInsertTransShptHeader`, `OnBeforeInsertTransRcptHeader`, `OnAfterInsertTransShptLine`, `OnAfterInsertTransRcptLine` — propagates `Parent Transfer Order #` and `Production Order No.` to posted shipment/receipt records.

3. **Parent Transfer Order creation** — `CreateParentTransferorder()` (single production order) and `CreateParentTransferorderSelection()` (multiple selected POs) — reads production order components where `Transfer From Location` is set and creates PTO lines.

4. **Purchase/G/L enhancements** — `CopyCashSupplierNameToPostedInv()`, `CopyCashSupplierNameToPostedRcpt()` preserve cash supplier info through posting; `TransferForeignServiceToGLEntry()` propagates a "Foreign Service" flag to G/L entries.

### Codeunit 76101 – Price List Import Mgt.

Utilities for Excel buffer parsing: `GetLastRow()`, `GetCellText()`, `ToDecimal()`, `ToDate()`, `ToBool()`, `ToAssignToType()`. Normalizes price source type input (customer, vendor, campaign, etc.).

### Codeunit 76102 – Purch. Order Dim. Validation

Event subscriber on `Release Purchase Document`. Validates that Dimensions 1–5 (Shortcut Dimensions 1, 2 and custom dimensions mapped to positions 3, 4, 8) are populated before a purchase order can be released.

### Key Architectural Patterns

**Event-driven, non-invasive extensions:** All business logic hooks into standard BC events. No base objects are modified, maintaining upgrade compatibility.

**Dimension cascading:** `Parent Transfer Order` carries LOB, Branch, Dept, SubDept, and Employee dimensions. Changes at the header level cascade to all lines via `UpdateAllLineDim()` using `DimMgt` (Dimension Management codeunit).

**Traceability chain:** Production Order → Parent Transfer Order → Transfer Order → Posted Transfer Shipment/Receipt. Custom fields on table extensions carry `Production Order No.` and `Parent Transfer Order #` through each posting step.

**"No. 2" item variant tracking:** A `No. 2` field (alternative item number) is extended onto Item, Purchase Lines, Sales Lines, Transfer Lines, Warehouse lines, Value Entries, and Item Ledger Entries — giving an alternative lookup key throughout the document flow.

### Table Extensions (key groups)

- **Tab-Ext76100, 76104** – Production order and lines: add `Parent Transfer Order #`, processing flags
- **Tab-Ext76102, 76103** – Warehouse Shipment/Receipt headers: add PTO and production order links
- **Tab-Ext76106, 76107** – Transfer Header/Line: add PTO and production order traceability
- **Tab-Ext76108–76111** – Posted Transfer Shipment/Receipt headers and lines: same traceability fields
- **Tab-Ext76114, 76115, 76119** – Purchase Header, Purchase Invoice Header, Purchase Receipt Header: add `Cash Supplier Name`
- **Tab-Ext76121, 76120** – Purchase Line, Sales Line: add dimensions and `No. 2`
- **Tab-Ext76128–76130** – General Journal Line, G/L Entry, Posted Gen. Journal Line: add `Foreign Service` flag
- **Tab-Ext76122–76127** – Warehouse and posted warehouse lines: add `No. 2`

### Permission Set

`PermissionSet76100 – GeneratedPermission` (Role ID: `SIGMA CYLINDERS MODIFICATIONS`) grants RIMD on all custom tables and X on all custom pages and codeunits in the 76100–76199 range.

## Testing

No test codeunits exist in the source. The `/.altestrunner` directory contains snapshot configuration files only.
