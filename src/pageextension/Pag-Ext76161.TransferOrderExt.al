pageextension 76161 "Transfer Order SCM Ext" extends "Transfer Order"
{
    layout
    {
        // The "Production Order No." field is defined with Editable = false on the
        // Transfer Header table (TransfersFromProduction, field 50150), so the page
        // control can never be made editable. Hide it and show an editable control
        // bound to a page variable instead.
        modify("Production Order No.")
        {
            Enabled = true;
            editable = true;
        }

    }


}
