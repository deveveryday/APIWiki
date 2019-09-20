/// <reference path="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.1.min.js" />
/// <reference path="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.17/jquery-ui.min.js" />

(function ($) {
    $.fn.dialogHelper = function (options) {

        // Read settings
        var settings = $.extend({
            dataDialogOpen: "dialog-open",
            dataDialogOptions: "dialog-options",
            dataDialogMessage: "dialog-message",
            dataConfirmPrompt: "confirm-prompt",
            dataConfirmTitle: "confirm-title",
            dataConfirmButtons: "confirm-buttons",
            dataConfirmDone: "confirm-done",
            confirmTitle: "Confirmation",
            confirmYes: "Yes",
            confirmNo: "No",
            showEffect: "clip",
            hideEffect: "clip"
        }, options);

        // Initialize general dialogs
        $("*[data-" + settings.dataDialogOpen + "]").each(function () {
            var dialogElement = $("#" + $(this).data(settings.dataDialogOpen));

            // Create dialog
            dialogElement.dialog({
                autoOpen: false,
                modal: true,
                show: settings.showEffect,
                hide: settings.hideEffect
            });

            // Set dialog options
            if (dialogElement.data(settings.dataDialogOptions) != null) {
                var options = dialogElement.data(settings.dataDialogOptions).split(";");
                for (var i = 0; i < options.length; i++) {
                    var option = options[i].split(":");
                    dialogElement.dialog("option", option[0], option[1]);
                }
            }

            // Recreate all buttons as dialog buttons
            var buttons = [];
            $("input[type=submit]", dialogElement).each(function () {
                var button = $(this);
                button.hide();
                buttons.push({ text: button.val(), click: function () { button.click() } });
            });
            if (buttons.length != 0) dialogElement.dialog("option", "buttons", buttons);

            // Move to <form runat=server>
            dialogElement.parent().appendTo($("form:first"));

            // Handle click
            $(this).click(function () {
                dialogElement.dialog("open");
                return false;
            });
        });

        // Initialize message dialogs
        $("*[data-" + settings.dataDialogMessage + "]").each(function () {
            $(this).dialog({
                modal: true,
                show: settings.showEffect,
                hide: settings.hideEffect,
                title: $(this).data(settings.dataDialogMessage),
                resizable: false,
                buttons: { OK: function () { $(this).dialog("close"); } }
            });
        });

        // Click confirmation
        $("*[data-" + settings.dataConfirmPrompt + "]").click(function () {
            var clickedObject = $(this);

            // Get href from this element or its children
            var href = clickedObject.attr("href");
            if (href == null) href = clickedObject.children("*[href]").attr("href");
            if (href && href.indexOf("javascript:") == 0) href = null;

            if (clickedObject.data(settings.dataConfirmDone) != true) {
                // Get button names
                var title = settings.confirmTitle;
                var buttonYes = settings.confirmYes;
                var buttonNo = settings.confirmNo;
                if (clickedObject.data(settings.dataConfirmTitle) != null) title = $(this).data(settings.dataConfirmTitle);
                if (clickedObject.data(settings.dataConfirmButtons) != null) {
                    var buttonNames = $(this).data(settings.dataConfirmButtons).split(";");
                    buttonYes = buttonNames[0];
                    buttonNo = buttonNames[1];
                }

                // Display jQuery UI confirmation dialog
                $("<div><p>" + clickedObject.data(settings.dataConfirmPrompt) + "</p></div>").dialog({
                    modal: true,
                    show: settings.showEffect,
                    hide: settings.hideEffect,
                    resizable: false,
                    title: title,
                    buttons: [{
                        text: buttonYes,
                        click: function () {
                            $(this).dialog("close");
                            if (href) {
                                window.location = href;
                            } else {
                                clickedObject.data(settings.dataConfirmDone, true);
                                clickedObject.click();
                            }
                        }
                    },
                    {
                        text: buttonNo,
                        click: function () {
                            $(this).dialog("close");
                        }
                    }]
                });
                clickedObject.data(settings.dataConfirmDone, false);
            }
            return clickedObject.data(settings.dataConfirmDone);
        });

    }
})(jQuery);