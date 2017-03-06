package view;

import api.Glyph;
import doom.html.Html.*;

class GlyphView {
  public static function render(g: Glyph, size: Int) {
    return div(["class" => "symbol"],
      [
        div(["class" => "top"],
          div(["class" => 'icon s$size'], i(["class" => '${g.name}']))
        ),
        div(["class" => "bottom"], g.name)
      ]
    );
  }
}
