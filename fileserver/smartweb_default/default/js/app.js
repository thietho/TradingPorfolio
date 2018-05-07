"use strict";
var app = {
    app: !1,
    isloaded: !1,
    header: !1,
    footer: !1,
    settings: {navDetectAuto: !0, navHorizontalDetectAuto: !0, screen_md: 992, sidepanelMobileHeight: 400, sidebarMobileHeight: 400},
    accordion_settings: {titleHeight: 50, noResize: !1},
    init: function () {
        this.app = $(".app"), this.header = $(".app > .app-header").length > 0 ? $(".app > .app-header") : !1, this.footer = $(".app > .app-footer").length > 0 ? $(".app > .app-footer") : !1
    },
    layout: function () {
        app.layoutSidebars(), 1 === $(".app-content > .app-header").length && $(".app-container").addClass("app-header-inside-content"), $(".app-container").each(function () {
            var a = $(this).find(".app-content");
            $(this).find(".app-sidebar").each(function () {
                $(this).hasClass("dir-left") && a.addClass("app-sidebar-left"), $(this).hasClass("dir-right") && a.addClass("app-sidebar-right")
            })
        }), $(".app-sidebar-left-closed .app-sidebar, .app-sidebar-right-closed .app-sidebar").css("display", "none"), $("[data-sidebar-toggle]").on("click", function () {
            var a = $($(this).data("sidebar-toggle")), b = a.hasClass("dir-left") ? "left" : "right", c = a.parent(".app-container");
            return c.hasClass("app-sidebar-" + b + "-closed") ? (a.css("display", "block"), setTimeout(function () {
                c.removeClass("app-sidebar-" + b + "-closed")
            }, 10)) : (a.css("display", "none"), c.addClass("app-sidebar-" + b + "-closed")), $(window).resize(), !1
        }), $("[data-sidebar-minimize]").on("click", function () {
            if ($(window).width() < app.settings.screen_md)return !1;
            var a = $($(this).data("sidebar-minimize")), b = a.hasClass("dir-left") ? "left" : "right", c = a.parent(".app-container"), d = "app-sidebar-" + b + "-minimized";
            return c.removeClass("app-sidebar-" + b + "-closed"), a.css("display", "block"), c.hasClass(d) ? (c.removeClass(d), a.removeClass("app-navigation-minimized").find("li.open").removeClass("open"), a.removeAttr("data-minimized").removeData("minimized"), a.hasClass("scroll") && a.mCustomScrollbar("update")) : (c.addClass(d), a.addClass("app-navigation-minimized").find("li.open").removeClass("open"), a.removeAttr("data-minimized").removeData("minimized"), a.hasClass("scroll") && a.mCustomScrollbar("disable", !0)), $(window).resize(), !1
        }), $("[data-sidepanel-toggle]").on("click", function () {
            var a = $($(this).data("sidepanel-toggle"));
            return $(".app").hasClass("app-sidepanel-open") ? ($(".app").removeClass("app-sidepanel-open"), "show" === a.data("overlay") && app.hideOverlay()) : ($(".app").addClass("app-sidepanel-open"), "show" === a.data("overlay") && app.showOverlay(function () {
                $(".app-overlay").on("click", function () {
                    $(".app").removeClass("app-sidepanel-open"), app.hideOverlay()
                })
            })), $(window).resize(), !1
        }), $("[data-separate-toggle-panel]").on("click", function () {
            $($(this).data("separate-toggle-panel")).toggleClass("open")
        })
    },
    layoutSidebars: function () {
        $(window).width() < app.settings.screen_md ? ($(".app-container").hasClass("app-sidebar-left-minimized") && ($(".app-container").removeClass("app-sidebar-left-minimized"), $(".app-sidebar.dir-left").removeClass("app-navigation-minimized"), $(".app-sidebar.dir-left").attr("data-minimized", "minimized")), $(".app-container").hasClass("app-sidebar-right-minimized") && ($(".app-container").removeClass("app-sidebar-right-minimized"), $(".app-sidebar.dir-right").removeClass("app-navigation-minimized"), $(".app-sidebar.dir-right").attr("data-minimized", "minimized"))) : ("minimized" === $(".app-sidebar.dir-left").data("minimized") && ($(".app-container").addClass("app-sidebar-left-minimized"), $(".app-sidebar.dir-left").addClass("app-navigation-minimized")), "minimized" === $(".app-sidebar.dir-right").data("minimized") && ($(".app-container").addClass("app-sidebar-right-minimized"), $(".app-sidebar.dir-right").addClass("app-navigation-minimized")))
    },
    navigation: function () {
        if ($(".app-navigation nav > ul").find("ul").parent("li").addClass("openable"), app.settings.navDetectAuto && !$(".app-navigation").hasClass("app-navigation-minimized")) {
            var a = window.location.pathname, b = a.split("/"), c = b[b.length - 1];
            $(".app-navigation a[href='" + c + "']").addClass("active").parents(".openable").addClass("open")
        }
        if ($(".app-navigation .openable > a").on("click", function (a) {
                //a.stopPropagation();
                var b = $(this).parent(".openable");
                //return b.hasClass("open") ? (b.removeClass("open"), b.find("li.open").removeClass("open")) : ((b.parents(".app-navigation").hasClass("app-navigation-minimized") || "close-other" === b.parents(".app-navigation").data("type")) && b.parent("ul").find("> li").not(b).removeClass("open"), b.addClass("open")), $(".app-navigation").hasClass("scroll") ? $(".app-navigation").mCustomScrollbar("update") : $(window).resize(), !1
                b.hasClass("open") ? (b.removeClass("open"), b.find("li.open").removeClass("open")) : ((b.parents(".app-navigation").hasClass("app-navigation-minimized") || "close-other" === b.parents(".app-navigation").data("type")) && b.parent("ul").find("> li").not(b).removeClass("open"), b.addClass("open")), $(".app-navigation").hasClass("scroll") ? $(".app-navigation").mCustomScrollbar("update") : $(window).resize(), !1
                return true;
            }),
            $(".app-navigation-horizontal nav > ul > li > ul").each(function () {
                $(this).parent("li").addClass("openable")
            }), app.settings.navHorizontalDetectAuto) {
            var a = window.location.pathname, b = a.split("/"), c = b[b.length - 1];
            $(".app-navigation-horizontal a[href='" + c + "']").parent("li").addClass("active").parents(".openable").addClass("active")
        }
        $(".app-navigation-horizontal .openable > a").on("click", function (a) {
            //a.stopPropagation();
            //var b = $(this).parents(".app-navigation-horizontal");
            //return b.find(".openable").removeClass("active"), $(this).parent(".openable").addClass("active"), !1
            //b.find(".openable").removeClass("active"), $(this).parent(".openable").addClass("active"), !1
            return true;
        })
    },
    navigationMobile: function () {
        $(".app-navigation-moblie-wrapper").length > 0 && ($("[data-navigation-mobile-toggle]").on("click", function (a) {
            return a.stopPropagation(), $(".app").toggleClass("app-navigation-moblie-open"), !1
        }), $(".app .app-navigation-mobile").on("click", function (a) {
            a.stopPropagation()
        }), $(".app .app-content").on("click", function () {
            $(".app").removeClass("app-navigation-moblie-open")
        })), $(".app-header-navigation").length > 0 && ($("[data-header-navigation-toggle]").on("click", function () {
            return $(".app-header-navigation").toggleClass("show"), !1
        }), $(".app-header-navigation li > a").on("click", function () {
            var a = $(this).parent("li");
            return a.find("ul").length > 0 || a.find(".app-header-navigation-megamenu").length > 0 ? (a.toggleClass("open"), !1) : void 0
        })), $(".app-navigation-horizontal").length > 0 && $("[data-navigation-horizontal-toggle]").on("click", function () {
            return $(".app-navigation-horizontal").toggleClass("show"), !1
        })
    },
    spy: function () {
        app.layoutSidebars();
        var a = $(window).height(), b = this._getHeaderHeight() + this._getFooterHeight() + this._getCustomOffset(), c = $(".app-container .app-sidebar.app-navigation-fixed").length > 0 ? !0 : !1, d = $(".app-container .app-sidebar"), e = $(".app-container .app-content"), f = $(".app-sidepanel").length > 0 ? $(".app-sidepanel") : !1;
        d.css({height: "auto"});
        var g = app._getTotalHeight(e.children()), h = this._getMaxHeight(d);
        if ($(window).width() > app.settings.screen_md) {
            if (g >= h ? (d.height(g), 0 === h && a > g + b && e.height(a - b)) : a >= h + b && d.height(a - b), d.each(function () {
                    "true" === $(this).attr("data-control-height") && $(this).height(h)
                }), $("[data-separate-control-height]").length > 0) {
                var g = $(".app-content").height() - app._getTotalHeight($(".app-content > div").not(".app-content-separate"));
                $("[data-separate-control-height]").height(g)
            }
            if (c) {
                var i = $(".app-container .app-sidebar.app-navigation-fixed");
                app.footer ? (i.addClass("app-navigation-fixed-absolute"), i.height($(".app").height() - app.footer.height())) : i.height(a)
            }
            f && f.height(a)
        } else $("[data-separate-control-height]").length > 0 && $("[data-separate-control-height]").css({height: "auto"}), d.each(function () {
            "true" === $(this).attr("data-control-height") ? $(this).height(app.settings.sidebarMobileHeight) : $(this).css({height: "auto"})
        }), f && f.height($(window).height());
        return !1
    },
    block: {
        "delete": function (a, b) {
            return a = $(a), a.fadeOut(200, function () {
                $(this).remove()
            }), "function" == typeof b && b(), app.spy(), !1
        }, toggle: function (a, b) {
            return a = $(a), a.toggleClass("block-toggled"), "function" == typeof b && b(), app.spy(), !1
        }, expand: function (a, b) {
            return a = $(a), a.toggleClass("block-expanded"), "function" == typeof b && b(), !1
        }
    },
    panel: {
        "delete": function (a, b) {
            return a = $(a), a.fadeOut(200, function () {
                $(this).remove()
            }), "function" == typeof b && b(), app.spy(), !1
        }, toggle: function (a, b) {
            return a = $(a), a.toggleClass("panel-toggled"), "function" == typeof b && b(), app.spy(), !1
        }, expand: function (a, b) {
            return a = $(a), a.toggleClass("panel-expanded"), "function" == typeof b && b(), !1
        }
    },
    resizableLayout: function () {
        if (0 === $(".app-content-resizable").length)return !1;
        var a = 300, b = $(".app-content-resizable"), c = b.children(".app-content-resizable-column");
        $(".app-content-resizable-column").not(":last-child").resizable({
            handles: "e", minWidth: a, start: function (a, b) {
                c.each(function () {
                    $(this).width($(this).width())
                })
            }, resize: function (c, d) {
                var e = $(this).next(".app-content-resizable-column"), f = $(".app-content-resizable-column").not(e).not($(this)), g = app._getMaxWidth(f), h = b.width() - g - d.size.width;
                return a > h ? (h = a, $(this).width(b.width() - g - a), e.width(h), !1) : void e.width(h)
            }, stop: function (a, d) {
                c.each(function () {
                    $(this).width(Math.round($(this).width() / b.width() * 100) + "%")
                })
            }
        })
    },
    features: {
        gallery: {
            init: function () {
                this.controlHeight(), $(".app-feature-gallery > li").on("click", function () {
                    var a = $(this).parents(".app-feature-gallery");
                    $(this).appendTo(a)
                })
            }, controlHeight: function () {
                $(".app-feature-gallery").each(function () {
                    var a = $(this).find("> li:first");
                    $(this).height(app._getTotalHeight(a.children()))
                })
            }
        }, preview: {
            init: function () {
                var a = $("#preview"), b = a.find(".modal-dialog"), c = a.find(".modal-body");
                $(".preview").on("click", function () {
                    return c.html(""), b.removeClass("modal-lg modal-sm modal-fw"), $(this).data("preview-image") && c.append(app.features.preview.build.image($(this).data("preview-image"))), $(this).data("preview-video") && c.append(app.features.preview.build.video($(this).data("preview-video"))), $(this).data("preview-href") && (c.html(app.features.preview.build.href($(this).data("preview-href"))), app_plugins.loaded()), $(this).data("preview-size") && b.addClass($(this).data("preview-size")), $(this).data("preview-title") && $(this).data("preview-description") && c.prepend(app.features.preview.build.text($(this).data("preview-title"), $(this).data("preview-description"))), a.modal("show"), !1
                }), a.on("hidden.bs.modal", function () {
                    c.html("")
                })
            }, build: {
                image: function (a) {
                    return $("<img>").attr("src", a).addClass("img-responsive")
                }, video: function (a) {
                    return $('<div class="app-preview-video"><iframe src="' + a + '" width="100%" frameborder="0" allowfullscreen></iframe></div>')
                }, href: function (a) {
                    var b = null;
                    return $.ajax({
                        url: a, type: "get", dataType: "html", async: !1, success: function (a) {
                            b = a
                        }
                    }), b
                }, text: function (a, b) {
                    return $("<div></div>").addClass("app-heading app-heading-small app-heading-condensed").append($("<div></div>").addClass("title").html("<h5>" + a + "</h5><p>" + b + "</p>"))
                }
            }
        }
    },
    accordion: function () {
        $(".app-accordion").length > 0 && $(".app-accordion").each(function () {
            var a = $(this);
            a.find(".item").each(function () {
                var b = $(this);
                a.data("type") || a.addClass("app-accordion-simple"), b.find(".heading").on("click", function () {
                    b.hasClass("open") ? b.removeClass("open").removeAttr("style") : b.addClass("open"), "close-other" === a.data("open") && a.find(".item").not(b).removeClass("open").removeAttr("style"), "full-height" === a.data("type") && app.accordionFullHeight(a)
                })
            })
        })
    },
    accordionFullHeight: function (a) {
        if (a.hasClass("app-accordion-simple"))return !1;
        var b = a.parent("div"), c = a.find(".item"), d = c.length, e = c.filter(".open").length;
        a.height(b.height());
        var c = c.filter(".open");
        c.removeAttr("style");
        var f = b.height() - (d - e) * app.accordion_settings.titleHeight, g = Math.floor(f / e);
        c.each(function () {
            $(this).height(g), $(this).find(".content").height(g - app.accordion_settings.titleHeight)
        })
    },
    accordionFullHeightSpy: function () {
        $(".app-accordion").each(function () {
            app.accordionFullHeight($(this))
        })
    },
    accordionFullHeightResize: function () {
        $(".app-accordion").removeAttr("style").find(".item.open").removeAttr("style"), delayBeforeFire(function () {
            app.accordionFullHeightSpy()
        }, 200)
    },
    contentTabs: function () {
        $(".app-content-tabs").length > 0 && ($(".app-content-tabs a .close-tab").on("click", function (a) {
            a.stopPropagation();
            var b = $(this).parents(".app-content-tabs");
            $($(this).parent("a").attr("href")).remove(), $(this).parents("li").remove(), b.find("li:first > a").click()
        }), $(".app-content-tabs a").on("click", function () {
            return $(".app-content-tabs a, .app-content-tab").removeClass("active"), $(this).addClass("active"), $($(this).attr("href")).addClass("active"), !1
        }))
    },
    showOverlay: function (a) {
        $(".app-overlay").addClass("show"), "function" == typeof a && a()
    },
    hideOverlay: function () {
        $(".app-overlay").removeClass("show")
    },
    formsFile: function () {
        $("input.file").each(function () {
            var a = "undefined" == typeof $(this).attr("title") ? "Browse" : $(this).attr("title"), b = $(this).attr("class").replace("file", "");
            b = "" === b ? " btn-default" : b, b = $(this).is(":disabled") ? b + " disabled" : b, $(this).wrap('<a href="#" class="file-input btn' + b + '"></a>').parent("a").append(a), $(this).parent("a").after('<span class="file-input-name"></span>')
        }), $("input.file").on("change", function () {
            var a, b, c;
            for (var a = $(this)[0].files, b = "", c = a.length > 1 ? c = ", " : "", d = 0; d < a.length; d++)b += a[d].name.split("/").pop().split("\\").pop() + (d !== a.length - 1 ? c : "");
            $(this).parent("a").next(".file-input-name").html(b)
        })
    },
    misc: function () {
        $(".panel-collapse").on("shown.bs.collapse", function () {
            $(window).resize()
        }), $("a[data-toggle='tab']").on("shown.bs.tab", function () {
            $(window).resize()
        }), $(".icons-preview > li").click(function () {
            var a = $(this).find(".name").html();
            $("#modal-icon-preview .modal-icon-preview-name").html(a), $("#modal-icon-preview .modal-icon-preview-span").val('<span class="' + a + '"></span>'), $("#modal-icon-preview .modal-icon-preview-value").val(a), $("#modal-icon-preview .modal-icon-preview-icon span").removeAttr("class").addClass(a), $("#modal-icon-preview").modal("show")
        }), $(".modal-icon-preview-value, .modal-icon-preview-span").on("click", function () {
            $(this).select()
        }), $(".app-lock .app-lock-user").on("click", function () {
            $(".app-lock").addClass("app-lock-open"), $(".app-lock .app-lock-form").show().addClass("animated bounceIn"), $(".app-lock .app-lock-form .form-control").focus()
        }), $.expr[":"].containsi = function (a, b, c) {
            return jQuery(a).text().toUpperCase().indexOf(c[3].toUpperCase()) >= 0
        }
    },
    doc_nav: function () {
        var a = $(window).height(), b = $(".doc_fix_nav"), c = b.parent("div").width() - 27;
        b.length > 0 && (b.width(c), b.height() > a && (b.height(a - 60), b.mCustomScrollbar({
            axis: "y",
            autoHideScrollbar: !0,
            scrollInertia: 200,
            advanced: {autoScrollOnFocus: !1}
        })), $(window).scroll(function () {
            var a = $(window).scrollTop(), c = $(document).height() - 397 - b.outerHeight(!0);
            a > 175 ? (b.addClass("fixed"), a > c ? b.addClass("stack") : b.removeClass("stack")) : b.removeClass("fixed")
        }))
    },
    loading: function (a, b) {
        var c = $.extend({state: "", value: [0, 0], position: "", speed: 20, complete: null}, b);
        if ("show" == a || "update" == a) {
            if ("show" == a) {
                $(".app-loading").remove();
                var d = '<div class="app-loading ' + c.position + '">\n                               <div class="app-loading-progress' + ("" != c.state ? " app-loading-" + c.state : "") + '" style="width:' + c.value[0] + '%;"></div>\n                           </div>';
                $("body").append(d)
            }
            var e = $.isArray(c.value) ? c.value[0] : $(".app-loading .app-loading-progress").width(), f = $.isArray(c.value) ? c.value[1] : c.value, g = setInterval(function () {
                $(".app-loading .app-loading-progress").css("width", e + "%"), e++, e > f && (clearInterval(g), $.isFunction(c.complete) && c.complete.call(this))
            }, c.speed)
        }
        "destroy" == a && $(".app-loading").remove()
    },
    statusbar: {
        init: function () {
            $(".app-statusbar-open, .app-statusbar-close").click(function () {
                return app.statusbar.open($(this).attr("href")), !1
            })
        }, open: function (a) {
            $(".app-statusbar").hide(), $(a).is(":hidden") && $(a).fadeIn()
        }
    },
    search: function () {
        $(".app-header-search").on("click", function () {
            $(".app-header-search > input").focus()
        })
    },
    _getTotalHeight: function (a) {
        var b = 0;
        return a.each(function () {
            b += $(this).outerHeight(!0)
        }), b
    },
    _getMaxHeight: function (a) {
        var b = 0;
        return a.each(function () {
            b = $(this).height() > b ? $(this).height() : b
        }), b
    },
    _getMaxWidth: function (a) {
        var b = 0;
        return a.each(function () {
            b = $(this).width() > b ? $(this).width() : b
        }), b
    },
    _getHeaderHeight: function () {
        return this.header ? this.header.outerHeight(!0) : 0
    },
    _getFooterHeight: function () {
        return this.footer ? this.footer.outerHeight(!0) : 0
    },
    _getCustomOffset: function () {
        return this.app.data("offset-height") ? this.app.data("offset-height") : 0
    },
    _delayBeforeFire: function () {
        var a = 0;
        return function (b, c) {
            clearTimeout(a), a = setTimeout(b, c)
        }
    },
    _toggleClass: function (a, b) {
        return $(a).toggleClass(b), app.spy(), !1
    },
    _addClass: function (a, b) {
        return $(a).addClass(b), app.spy(), !1
    },
    _removeClass: function (a, b) {
        return $(a).removeClass(b), app.spy(), !1
    },
    loaded: function () {
        app.spy(), app.app.addClass("app-loaded"), app.accordion(), app.accordionFullHeightSpy(), setTimeout(function () {
            $("body").scrollTop(0)
        }, 200), app.isloaded = !0
    }
};
$(function () {
    app.init(), app.layout(), app.resizableLayout(), app.navigation(), app.navigationMobile(), app.contentTabs(), app.formsFile(), app.features.gallery.init(), app.features.preview.init(), app.statusbar.init(), app.search(), app.misc(), app.doc_nav()
}), $(window).resize(function () {
    delayBeforeFire(function () {
        app.accordionFullHeightResize(), app.features.gallery.controlHeight(), app.spy()
    }, 100)
});
var delayBeforeFire = function () {
    var a = 0;
    return function (b, c) {
        clearTimeout(a), a = setTimeout(b, c)
    }
}();
/* IN DOWNLOADED PACKAGE YOU WILL FIND WELL STRUCTURED, FORMATTED AND COMMENTED SOURCE CODE */