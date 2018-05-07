"use strict";
var app_plugins = {
    checkbox_radio: function () {
        ($(".app-checkbox").length > 0 || $(".app-radio").length > 0) && $(".app-checkbox label, .app-radio label").each(function () {
            $(this).append("<span></span>")
        })
    },
    switch_button: function () {
        $(".switch").length > 0 && $(".switch").each(function () {
            $(this).append("<span></span>")
        })
    }, isotope: function () {
        var a = $(".grid").isotope({itemSelector: ".grid-element", layoutMode: "fitRows", percentPosition: !0});
        $("button[data-filter]").on("click", function () {
            var b = $(this).attr("data-filter");
            a.isotope({filter: b}), $(this).parents(".btn-group").find(".btn-primary").removeClass("btn-primary").addClass("btn-default"), $(this).removeClass("btn-default").addClass("btn-primary")
        }), $(window).resize(function () {
            setTimeout(function () {
                a.isotope("layout"), app.accordionFullHeightResize(), app.features.gallery.controlHeight(), app.spy()
            }, 100)
        })
    }, formSpinner: function () {
        $("input.spinner").length > 0 && ($("input.spinner").each(function () {
            $(this).wrap('<div class="spinner-wrapper"></div>'), $(this).after('<button class="spinner-button-up"><span class="fa fa-angle-up"></span></button>'), $(this).after('<button class="spinner-button-down"><span class="fa fa-angle-down"></span></button>')
        }), $(".spinner-button-up").on("click", function () {
            var a = $(this).parent(".spinner-wrapper").find("input"), b = a.attr("data-spinner-max") ? parseFloat(a.data("spinner-max")) : !1, c = a.attr("data-spinner-min") ? parseFloat(a.data("spinner-min")) : !1, d = a.attr("data-spinner-step") ? parseFloat(a.data("spinner-step")) : 1, e = parseFloat(a.val()) + d;
            return "undefined" != typeof b && b !== !1 && e > b ? !1 : "undefined" != typeof c && c !== !1 && c > e ? !1 : (a.val(e), !1)
        }), $(".spinner-button-down").on("click", function () {
            var a = $(this).parent(".spinner-wrapper").find("input"), b = a.attr("data-spinner-max") ? parseFloat(a.data("spinner-max")) : !1, c = a.attr("data-spinner-min") ? parseFloat(a.data("spinner-min")) : !1, d = a.attr("data-spinner-step") ? parseFloat(a.data("spinner-step")) : 1, e = parseFloat(a.val()) - d;
            return "undefined" != typeof b && b !== !1 && e > b ? !1 : "undefined" != typeof c && c !== !1 && c > e ? !1 : (a.val(e), !1)
        }))
    }, customScrollBar: function () {
        $(".scroll").length > 0 && $(".scroll").mCustomScrollbar({axis: "y", autoHideScrollbar: !0, scrollInertia: 200, advanced: {autoScrollOnFocus: !1}})
    }, bootstrap_select: function () {
        $(".bs-select").length > 0 && $(".bs-select").selectpicker({iconBase: "", tickIcon: "icon-check"})
    }, bootstrap_datepicker: function () {
        $(".bs-datepicker").length > 0 && $(".bs-datepicker").datetimepicker({format: "DD-MM-YYYY"}), $(".bs-datetimepicker").length > 0 && $(".bs-datetimepicker").datetimepicker(), $(".bs-timepicker").length > 0 && $(".bs-timepicker").datetimepicker({format: "LT"}), $(".bs-datepicker-weekends").length > 0 && $(".bs-datepicker-weekends").datetimepicker({
            format: "DD-MM-YYYY",
            daysOfWeekDisabled: [0, 6]
        }), $(".bs-datepicker-inline").length > 0 && $(".bs-datepicker-inline").datetimepicker({inline: !0}), $(".bs-datepicker-inline-time").length > 0 && $(".bs-datepicker-inline-time").datetimepicker({
            inline: !0,
            sideBySide: !0
        }), $(".bs-datepicker-inline-years").length > 0 && $(".bs-datepicker-inline-years").datetimepicker({inline: !0, viewMode: "years"})
    }, bootstrap_popover: function () {
        $("[data-toggle='popover']").popover(), $(".popover-hover").hover(function () {
            $(this).popover("show")
        }, function () {
            $(this).popover("hide")
        }), $(".modal").on("show.bs.modal", function () {
            $("[data-toggle='popover']").popover("hide")
        })
    }, bootstrap_tooltip: function () {
        $("[data-toggle='tooltip']").tooltip()
    }, maskedInput: function () {
        $("input[class^='mask_']").length > 0 && ($("input.mask_tin").mask("99-9999999"), $("input.mask_ssn").mask("999-99-9999"), $("input.mask_date").mask("9999-99-99"), $("input.mask_date_rev").mask("99-99-9999"), $("input.mask_product").mask("a*-999-a999"), $("input.mask_phone").mask("99 (999) 999-99-99"), $("input.mask_phone_ext").mask("99 (999) 999-9999? x99999"), $("input.mask_credit").mask("9999-9999-9999-9999"), $("input.mask_percent").mask("99%"))
    }, noty: function () {
        $(".notify").on("click", function () {
            noty({
                text: $(this).data("notify"),
                type: $(this).data("notify-type"),
                layout: $(this).data("notify-layout") ? $(this).data("notify-layout") : "topRight",
                animation: {open: "animated bounceIn", close: "animated fadeOut", speed: 200}
            })
        })
    }, datatables: function () {
        $(".datatable-basic").length > 0 && $(".datatable-basic").DataTable({searching: !1, paging: !1, info: !1}), $(".datatable-extended").length > 0 && $(".datatable-extended").DataTable()
    }, knob: function () {
        $(".knob").knob({
            format: function (a) {
                return a + "%"
            }
        })
    }, sparkline: function () {
        $(".sparkline").length > 0 && $(".sparkline").sparkline("html", {enableTagOptions: !0, disableHiddenCheck: !0})
    }, loaded: function () {
        app_plugins.customScrollBar(), app_plugins.checkbox_radio(), app_plugins.formSpinner(), app_plugins.switch_button(), app_plugins.bootstrap_select(), app_plugins.bootstrap_popover(), app_plugins.bootstrap_datepicker(), app_plugins.bootstrap_tooltip(), app_plugins.maskedInput(), app_plugins.datatables(), app_plugins.knob(), app_plugins.sparkline(), app_plugins.isotope(), app_plugins.noty()
    }
};
$(function () {
    app_plugins.loaded()
}), $(document).ready(function () {
    app.loaded()
});
/* IN DOWNLOADED PACKAGE YOU WILL FIND WELL STRUCTURED, FORMATTED AND COMMENTED SOURCE CODE */