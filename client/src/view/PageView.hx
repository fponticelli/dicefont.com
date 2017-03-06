package view;

import api.*;
import doom.html.Html.*;
import Markdown.*;

class PageView {
  public static function render(page: Page, glyphs: Array<Glyph>) {
    var contents = [raw(markdownToHtml(page.content))];

    if(page.name == "home") {
      contents.push(renderGlyphs(glyphs));
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

  public static function renderGlyphs(glyphs: Array<Glyph>) {
    return div(["class" => "glyphs"], glyphs.map(function(g) {
      return div(["class" => "glyph"], GlyphView.render(g));
    }));
  }
}
