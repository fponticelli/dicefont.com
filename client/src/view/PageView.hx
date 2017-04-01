package view;

import api.*;
import doom.html.Html.*;
import Markdown.*;
using thx.Strings;
using thx.Url;

class PageView {
  public static function render(baseDistUrl: Url, page: Page, groups: Array<Group>) {
    var contents = [raw(markdown(baseDistUrl, page.content))];

    if(page.name == "home") {
      contents.push(renderGroups(groups));
    }
    return div(
      ["class" => "site-page"],
      [
        div(
          ["class" => "markdown"],
          contents
        )
      ]
    );
  }

  public static function renderGroups(groups: Array<Group>) {
    return div(["class" => "groups"], groups.map(function(g) {
      return div(["class" => "glyph"], [
        h2(g.title),
        h3(["class" => "notes"], 'ideal size ${g.size}px'),
        renderGlyphs(g.glyphs, g.size)
      ]);
    }));
  }

  public static function renderGlyphs(glyphs: Array<Glyph>, size: Int) {
    return div(["class" => "glyphs"], glyphs.map(function(g) {
      return div(["class" => 'glyph'], GlyphView.render(g, size));
    }));
  }

  public static function markdown(baseDistUrl: Url, s: String) {
    s = s.replace("${cdndist}", baseDistUrl.toString());
    return markdownToHtml(s);
  }
}
