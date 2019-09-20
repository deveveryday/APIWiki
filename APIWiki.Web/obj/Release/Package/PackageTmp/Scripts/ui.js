/// <reference path="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.1.min.js" />
/// <reference path="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.17/jquery-ui.min.js" />
/// <reference path="jquery.sewenEditor.js" />
/// <reference path="jquery.dialogHelper.js" />

$(function () {
    // Activate dialog helper
    $(this).dialogHelper();

    // Add wiki editor toolbar
    $("*[data-seweneditor-toolbar]").each(function () {
        $(this).sewenEditor({
            culture: $("meta[name=x-ui-culture]").attr("content"),
            toolbarButtons: $(this).data("seweneditor-toolbar"),
            textboxClass: "textbox ui-corner-all",
            customCommand: function (textarea, command) {
                switch (command) {
                    case "Preview":
                        var jqxhr = $.post("/edit/preview", { markupHtml: textarea.val() }, HandlePreviewResponse, "html");
                        jqxhr.error(function (jqXHR, textStatus, errorThrown) { window.alert("Async HTTP request failed!\r\n" + textStatus + ": " + errorThrown); });
                        break;
                    default:
                        window.alert("Invalid command:" + command);
                }
            }
        });
    });

    // Add jQuery UI and similar styling
    $(".button").button();
    $("article").addClass("ui-widget-content ui-corner-all");
    $("article>header").addClass("ui-widget-header ui-corner-top");
    $("article>footer").addClass("ui-corner-bottom");
    $("form>header>ul").addClass("ui-widget-content ui-corner-all");
    $(".textbox").addClass("ui-corner-all");
    $("textarea").removeClass("ui-corner-all").addClass("ui-corner-left");
    $(".aspNetDisabled").addClass("ui-state-disabled");
    $(".externalLinkIcon").addClass("ui-icon ui-icon-extlink");
});

function HandlePreviewResponse(html) {
    var dialog = $(html);
    $("a[href]", dialog).click(function () { return false; });
    dialog.dialog({
        title: "Preview",
        modal: true,
        show: "clip",
        hide: "clip",
        minWidth: 400,
        minHeight: 400,
        width: Math.min($(window).width() - 200, 1000),
        height: $(window).height() - 200,
        buttons: {
            OK: function () {
                $(this).dialog("close");
                $(this).dialog("destroy");
            }
        }
    });
}