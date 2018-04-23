var minSize = 170;
var offset = 30;
function OnCategoryChanged(s, e) {
    productsCombo.PerformCallback();
    detailsPanel.SetVisible(false);
}

function OnInit(s, e) {
    AdjustComboboxWidth(s);
}

function OnProductChanged(s, e) {
    var item = s.FindItemByText(s.GetText());
    if (item != undefined) {
        detailsPanel.PerformCallback();
        AdjustComboboxWidth(s);
    }
}

function OnSearchButtonClick(s, e) {
    productsCombo.ShowDropDown();
}

function OnEndCallback(s, e) {
    detailsPanel.SetVisible(true);
    AdjustTableWidth($('#detailTable'));
}
function AdjustComboboxWidth(s) {
    var input = s.GetInputElement();
    var inputStyles = window.getComputedStyle(input);
    var parent = input.parentElement;
    var span = document.createElement('span');
    span.style.whiteSpace = "nowrap";
    span.style.fontSize = inputStyles.fontSize;
    span.style.fontFamily = inputStyles.fontFamily;
    span.appendChild(document.createTextNode(input.value));
    parent.appendChild(span);
    if ($(span).width() + offset > minSize) {
        s.SetWidth($(span).width() + offset);
    }
    else s.SetWidth(minSize);
    parent.removeChild(span);
}

function AdjustTableWidth(table) {
    table.width(productsCombo.GetWidth() + categoriesCombo.GetWidth());
}