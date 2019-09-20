/// <reference path="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.1.min.js" />
/// <reference path="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.17/jquery-ui.min.js" />
/// <reference path="jquery.textinputs.min.js" />

var SEWEN_EDITOR_LOCALIZATION = {
    cs: {
        DefaultToolbarButtons: "B:Tučné;I:Kurzíva;U:Podtržené;S:Přeškrtnuté;Sup:Horní index;Sub:Dolní index;;H1:Nadpis 1;H2:Nadpis 2;H3:Nadpis 3;H4:Nadpis 4;H5:Nadpis 5;H6:Nadpis 6;;WikiLink:Odkaz na stránku wiki;ExtLink:Externí odkaz (URL);;Ul:Seznam s odrážkami;Ol:Číslovaný seznam;;CodeBlock:Zdrojový kód",
        LinkDialog_Title: "Vložit odkaz",
        LinkDialog_Prompt_Page: "Název stránky:",
        LinkDialog_Prompt_URL: "URL:",
        LinkDialog_Prompt_Text: "Text odkazu:",
        CodeDialog_Title: "Vložit zdrojový kód",
        CodeDialog_Prompt_Lang: "Jazyk pro zvýraznění syntaxe:",
        CodeDialog_None: "žádný",
        Button_OK: "OK",
        Button_Cancel: "Storno"
    },
    en: {
        DefaultToolbarButtons: "B:Bold;I:Italic;U:Underline;S:Strikethrough;Sup:Superscript;Sub:Subscript;;H1:Heading 1;H2:Heading 2;H3:Heading 3;H4:Heading 4;H5:Heading 5;H6:Heading 6;;WikiLink:Link to Wiki Page;ExtLink:External Link (URL);;Ul:Bulleted List;Ol:Numbered List;;CodeBlock:Source code",
        LinkDialog_Title: "Insert Link",
        LinkDialog_Prompt_Page: "Wiki Page:",
        LinkDialog_Prompt_URL: "URL: ",
        LinkDialog_Prompt_Text: "Link Text:",
        CodeDialog_Title: "Insert Source Code",
        CodeDialog_Prompt_Lang: "Language for syntax highlighting:",
        CodeDialog_None: "none",
        Button_OK: "OK",
        Button_Cancel: "Cancel"
    }
};

(function ($) {
    $.fn.sewenEditor = function (options) {
        // Settings
        var settings = $.extend({
            culture: "en",
            textboxClass: "",
            toolbarButtons: "",
            customCommand: function (textarea, command) { window.alert("Custom command '" + command + "' is not implemented."); }
        }, options);
        if (settings.toolbarButtons == "") settings.toolbarButtons = SEWEN_EDITOR_LOCALIZATION[settings.culture]["DefaultToolbarButtons"];

        return this.each(function () {
            // Create the toolbar div
            var textarea = $(this);
            var toolbar = $("<div class='sewen-editor-toolbar ui-corner-top'></div>");
            toolbar.insertBefore(textarea);
            textarea.css("border-top", "none").css("border-top-left-radius", "0").css("border-top-right-radius", "0");

            // Function that adds a new button
            var addButton = function (text, command) {
                var btn = $("<button title='" + text + "' class='" + command + "' />").button({
                    text: false
                });
                toolbar.append(btn);
                return btn;
            };

            // Function that returns a localized string
            var localize = function (key) {
                return SEWEN_EDITOR_LOCALIZATION[settings.culture][key];
            };

            // Text operation functions
            var textOperations = {
                StartsWith: function (value, token) {
                    return value.indexOf(token) == 0;
                },
                EndsWith: function (value, token) {
                    return value.lastIndexOf(token) == value.length - token.length;
                },

                TrimSelection: function (selection, text) {
                    // if the selection starts or ends with whitespace, cut it off
                    while (selection.start < selection.end && /\s/.test(text.substring(selection.start, selection.start + 1))) {
                        selection.start += 1;
                    }
                    while (selection.end > selection.start && /\s/.test(text.substring(selection.end - 1, selection.end))) {
                        selection.end -= 1;
                    }
                },

                Wrap: function (token) {
                    // inserts the specified token before and after the selection or removes it when it is already there
                    var selection = textarea.getSelection();
                    var text = textarea.val();
                    textOperations.TrimSelection(selection, text);

                    // try to extend the selection at the beginning and end
                    if (((selection.start >= token.length) && (text.substring(selection.start - token.length, selection.start) == token))
                        && ((selection.end < text.length + token.length) && (textarea.val().substring(selection.end, selection.end + token.length) == token))) {
                        selection.start -= token.length;
                        selection.end += token.length;
                    }
                    textarea.setSelection(selection.start, selection.end);

                    if (selection.start == selection.end) {
                        // nothing is selected, insert the token at the cursor
                        textarea.replaceSelectedText(token + token);
                        textarea.setSelection(selection.start + token.length, selection.start + token.length);
                    } else {
                        // selection exists
                        var value = text.substring(selection.start, selection.end);
                        if ((value.length >= token.length * 2) && textOperations.StartsWith(value, token) && textOperations.EndsWith(value, token)) {
                            // remove tokens as the string starts and ends with them already
                            value = value.substring(token.length, value.length - token.length);
                        } else {
                            // add tokens before and after
                            value = token + value + token;
                        }
                        textarea.replaceSelectedText(value);
                        textarea.setSelection(selection.start, selection.start + value.length);
                    }
                },

                Prefix: function (token) {
                    // inserts or removes specified prefix from the selection or current line
                    var selection = textarea.getSelection();
                    var text = textarea.val();
                    textOperations.TrimSelection(selection, text);
                    textarea.setSelection(selection.start, selection.end);

                    if (selection.start == selection.end) {
                        // nothing is selected, select current line
                        var start = text.lastIndexOf("\n", selection.start);
                        var end = text.indexOf("\n", selection.start);
                        if (start < 0) start = 0; else start++;
                        if (end < 0) end = text.length;
                        textarea.setSelection(start, end);
                        selection = textarea.getSelection();
                    }

                    var value = selection.text;
                    if (textOperations.StartsWith(value, token)) {
                        // remove token
                        textarea.replaceSelectedText(value.substring(token.length));
                        textarea.setSelection(selection.start, selection.end - token.length);
                    } else {
                        // add token
                        textarea.replaceSelectedText(token + value);
                        textarea.setSelection(selection.start, selection.end + token.length);
                    }
                },

                InsertAtSelection: function (selection, value) {
                    if (selection.start > 0) value = textarea.val().substring(0, selection.start) + value;
                    if (selection.end < textarea.val().length) value = value + textarea.val().substring(selection.end, textarea.val().length);
                    textarea.val(value);
                }
            };

            // Function that shows the link dialog
            function showLinkDialog(linkType, successCallback) {
                var selection = textarea.getSelection();

                var dialogHtml = "<div>"
                               + "<p><label for='ldurltext'>" + localize("LinkDialog_Prompt_Text") + "</label>"
                               + "<br/><input id='ldurltext' type='text' class='" + settings.textboxClass + "' /></p>"
                               + "<p><label for='ldurltarget'>" + localize("LinkDialog_Prompt_" + linkType) + "</label>"
                               + "<br/><input id='ldurltarget' type='text' class='" + settings.textboxClass + "' /></p>"
                               + "</div>";
                var dialog = $(dialogHtml).dialog({
                    modal: true,
                    show: "clip",
                    hide: "clip",
                    title: localize("LinkDialog_Title"),
                    minWidth: 450,
                    resizable: true,
                    buttons: [
                        { 
                            text: localize("Button_OK"), 
                            click: function () {
                                var text = $("#ldurltext", $(this)).val();
                                var target = $("#ldurltarget", $(this)).val();
                                if (text) target = text + "|" + target;

                                // Close & destroy dialog
                                $(this).dialog("close");
                                $(this).dialog("destroy");

                                // Call the success function
                                textarea.focus();
                                textarea.setSelection(selection.start, selection.end);
                                successCallback(target);
                            }
                        },
                        { 
                            text: localize("Button_Cancel"), 
                            click: function () {
                                // Close & destroy dialog
                                $(this).dialog("close");
                                $(this).dialog("destroy");
                            } 
                        }
                    ]
                });
                // Set focus to first textbox
                $("#ldurltext", dialog).focus();
            };

            // Function that shows source code dialog
            function showSourceCodeDialog(successCallback) {
                var dialogHtml = "<div><p>" + localize("CodeDialog_Prompt_Lang") + "</p>"
                               + "<p><input type='radio' id='hlt0' name='hlt' value='' checked='checked' /> <label for='hlt0'>" + localize("CodeDialog_None") + "</label>"
                               + "<br/><input type='radio' id='hlt1' name='hlt' value='aspx c#' /> <label for='hlt1'>ASPX + C#</label>"
                               + "<br/><input type='radio' id='hlt2' name='hlt' value='aspx vb.net' /> <label for='hlt2'>ASPX + VB.NET</label>"
                               + "<br/><input type='radio' id='hlt3' name='hlt' value='ashx' /> <label for='hlt3'>ASHX</label>"
                               + "<br/><input type='radio' id='hlt4' name='hlt' value='c#' /> <label for='hlt4'>C#</label>"
                               + "<br/><input type='radio' id='hlt5' name='hlt' value='c++' /> <label for='hlt5'>C++</label>"
                               + "<br/><input type='radio' id='hlt6' name='hlt' value='vb.net' /> <label for='hlt6'>VB.NET</label>"
                               + "<br/><input type='radio' id='hlt7' name='hlt' value='html' /> <label for='hlt7'>HTML</label>"
                               + "<br/><input type='radio' id='hlt8' name='hlt' value='sql' /> <label for='hlt8'>SQL</label>"
                               + "<br/><input type='radio' id='hlt9' name='hlt' value='java' /> <label for='hlt9'>Java</label>"
                               + "<br/><input type='radio' id='hltA' name='hlt' value='javascript' /> <label for='hltA'>JavaScript</label>"
                               + "<br/><input type='radio' id='hltB' name='hlt' value='xml' /> <label for='hltB'>XML</label>"
                               + "<br/><input type='radio' id='hltC' name='hlt' value='php' /> <label for='hltC'>PHP</label>"
                               + "<br/><input type='radio' id='hltD' name='hlt' value='css' /> <label for='hltD'>CSS</label>"
                               + "<br/><input type='radio' id='hltE' name='hlt' value='powershell' /> <label for='hltE'>PowerShell</label>"
                               + "</p></div>";
                var dialog = $(dialogHtml).dialog({
                    modal: true,
                    show: "clip",
                    hide: "clip",
                    title: localize("CodeDialog_Title"),
                    width: 250,
                    resizable: false,
                    buttons: [
                        { 
                            text: localize("Button_OK"), 
                            click: function () {
                                // Get selected language
                                var lang = $("input[@name='hlt']:checked", $(this)).val();

                                // Close & destroy dialog
                                $(this).dialog("close");
                                $(this).dialog("destroy");

                                // Call success callback
                                if(lang == "") {
                                    successCallback("{{", "}}");
                                } else {
                                    successCallback("{code:" + lang + "}\r\n", "\r\n{code:" + lang + "}");
                                }
                            } 
                        },
                        { 
                            text: localize("Button_Cancel"), 
                            click: function () { 
                                // Close & destroy dialog
                                $(this).dialog("close");
                                $(this).dialog("destroy");
                            } 
                        }
                    ]
                });
            }

            // Create toolbar buttons from toolbar string specification
            var buttonData = settings.toolbarButtons.split(";");
            for (var i = 0; i < buttonData.length; i++) {
                if (buttonData[i] == "") {
                    // Add separator
                    toolbar.append($("<span class='separator'></span>"));
                    continue;
                } else {
                    // Add button
                    var command = buttonData[i].split(':')[0];
                    var text = buttonData[i].split(':')[1];
                    var button = addButton(text, command);
                    switch (command) {
                        // Basic formatting    
                        case "B":
                            button.click(function () { textOperations.Wrap("*"); return false; });
                            break;
                        case "I":
                            button.click(function () { textOperations.Wrap("_"); return false; });
                            break;
                        case "U":
                            button.click(function () { textOperations.Wrap("+"); return false; });
                            break;
                        case "S":
                            button.click(function () { textOperations.Wrap("--"); return false; });
                            break;
                        case "Sup":
                            button.click(function () { textOperations.Wrap("^^"); return false; });
                            break;
                        case "Sub":
                            button.click(function () { textOperations.Wrap(",,"); return false; });
                            break;
                        // Headings    
                        case "H1":
                            button.click(function () { textOperations.Prefix("! "); return false; });
                            break;
                        case "H2":
                            button.click(function () { textOperations.Prefix("!! "); return false; });
                            break;
                        case "H3":
                            button.click(function () { textOperations.Prefix("!!! "); return false; });
                            break;
                        case "H4":
                            button.click(function () { textOperations.Prefix("!!!! "); return false; });
                            break;
                        case "H5":
                            button.click(function () { textOperations.Prefix("!!!!! "); return false; });
                            break;
                        case "H6":
                            button.click(function () { textOperations.Prefix("!!!!!! "); return false; });
                            break;
                        // Lists    
                        case "Ul":
                            button.click(function () { textOperations.Prefix("* "); return false; });
                            break;
                        case "Ol":
                            button.click(function () { textOperations.Prefix("# "); return false; });
                            break;
                        // Links    
                        case "WikiLink":
                            button.click(function () { showLinkDialog("Page", function (val) { textarea.replaceSelectedText("[" + val + "]") }); return false; });
                            break;
                        case "ExtLink":
                            button.click(function () { showLinkDialog("URL", function (val) { textarea.replaceSelectedText("[url:" + val + "]") }); return false; });
                            break;
                        // Code
                        case "CodeBlock":
                            button.click(function() { showSourceCodeDialog(function(prefix, postfix) { textarea.surroundSelectedText(prefix, postfix); }); return false; });
                            break;
                        default:
                            button.click(function () { settings.customCommand(textarea, command); return false; });
                            break;
                    }
                }
            }

            // Handle keyboard shortcuts
            textarea.keydown(function (e) {
                // Find command based on key shortcut
                var command;
                if(e.ctrlKey && !e.altKey) {
                    if (e.keyCode == 66) { command = "B"; }              // Ctrl+B
                    else if (e.keyCode == 73) { command = "I"; }         // Ctrl+I
                    else if (e.keyCode == 83) { command = "U"; }         // Ctrl+U
                    else if (e.keyCode == 49) { command = "H1"; }        // Ctrl+1
                    else if (e.keyCode == 50) { command = "H2"; }        // Ctrl+2
                    else if (e.keyCode == 51) { command = "H3"; }        // Ctrl+3
                    else if (e.keyCode == 52) { command = "H4"; }        // Ctrl+4
                    else if (e.keyCode == 53) { command = "H5"; }        // Ctrl+5
                    else if (e.keyCode == 54) { command = "H6"; }        // Ctrl+6
                    else if (e.keyCode == 75) { command = "ExtLink"; }   // Ctrl+K
                    else if (e.keyCode == 76) { command = "WikiLink"; }  // Ctrl+L
                }
                if (command == null) return; // no command found

                // Execute command
                $("." + command, toolbar).click();
                return false;
            });

        });

    };
})(jQuery);
