package view;

import doom.html.Html.*;
import Loc.msg;
import haxe.ds.Option;
import api.*;
using thx.Arrays;

class Header {
  public static function render(contents: SiteContents, page: Option<Page>) {
    return div(
      ["class" => "header"],
      [
        div(
          ["class" => "top-header"],
          [
            div(["class" => "center"], [
              div(["class" => "logo"], a(["href" => "#/"], i(["class" => "df-d20-20"]))),
              div(["class" => "title"], a(["href" => "#/"], msg.header_title)),
              div(["class" => "links"], renderPages(contents.pages, page))
            ])
          ]
        ),
        div(["class" => "github-ribbon"], [
          a([
              "class" => "github-ribbon__link",
              "href" => "https://github.com/fponticelli/dicefont",
              "title" => "Fork me on GitHub"
            ],
            "Fork me on GitHub"
          )
        ])
      ]
    );
  }

  public static function renderPages(list: Array<PageAbstract>, current: Option<Page>) {
    return ul(
      ["class" => "site-links"],
      list.map(function(page) {
        return switch current {
          case Some(current) if(current.name == page.name):
            li(renderCurrent(page));
          case _:
            li(renderLink(page));
        }
      }).interspersef(function() {
        return li(["class" => "active"], "•");
      })
    );
  }

  static function renderLink(page: PageAbstract)
    return a(["href" => "#/" + page.name], page.name);

  static function renderCurrent(page: PageAbstract)
    return span(["class" => "active"], page.name);
}
