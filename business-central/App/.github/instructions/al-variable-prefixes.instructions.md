---
name: "AL Variable Prefixes"
description: "Use when creating or modifying AL code in Session 2. Prefix local variables with l and global variables with g."
applyTo: "src/Session2/**/*.al"
---

# AL Variable Prefixes

- Prefix every variable declared in a procedure-level `var` block with `l`.
- Prefix every variable declared in an object-level `var` block with `g`.
- Follow the prefix with a descriptive PascalCase name, for example `lCustomer` and `gServiceUrlErr`.
- Treat label variables like other variables: their declaration scope determines their prefix.
- Do not prefix procedure parameters, return values, fields, procedures, or object names.
- When modifying existing Session 2 code, rename affected variables consistently throughout the touched object.

```al
codeunit 50100 "Example Processor"
{
    procedure Process(CustomerNo: Code[20])
    var
        lCustomer: Record Customer;
    begin
        lCustomer.Get(CustomerNo);
    end;

    var
        gCustomerMissingErr: Label 'The customer does not exist.';
}
```

<!-- Create codeunit 50104 "ACA Follow-up Summary" in Session2. Add a public CountOverdueFollowUps(AsOfDate: Date): Integer procedure that rejects 0D with an object-level error label and counts incomplete follow-ups dated before AsOfDate. Use a procedure-local record variable, add XML documentation, and do not modify other files. -->