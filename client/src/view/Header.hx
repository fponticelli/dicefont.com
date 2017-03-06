package view;

import doom.html.Html.*;
import Loc.msg;
import haxe.ds.Option;
import api.*;

class Header {
  public static function render(contents: SiteContents, page: Option<Page>) {
    return div(
      ["class" => "header"],
      [
        div(
          ["class" => "top-header"],
          [
            div(["class" => "center title"], a(["href" => "#/"], msg.header_title)),
            div(["class" => "center links"], renderPages(contents.pages, page))
          ]
        )
      ]
    );
  }

  public static function renderPages(list: Array<PageAbstract>, current: Option<Page>) {
    return ul(
      ["class" => "site-links"],
      list.map(function(page) {
        return switch current {
          case Some(current) if(current.name == page.name):
            renderCurrent(page);
          case _:
            renderLink(page);
        }
      })
    );
  }

  static function renderLink(page: PageAbstract)
    return a(["href" => "#/" + page.name], page.name);

  static function renderCurrent(page: PageAbstract)
    return span(page.name);
}
