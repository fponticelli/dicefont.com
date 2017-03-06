package view;

import api.*;
import doom.html.Html.*;
import Markdown.*;

class PageView {
  public static function render(page: Page, groups: Array<Group>) {
    var contents = [raw(markdownToHtml(page.content))];

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
}
