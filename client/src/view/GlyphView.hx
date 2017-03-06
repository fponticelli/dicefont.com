package view;

import api.Glyph;
import doom.html.Html.*;

class GlyphView {
  public static function render(g: Glyph) {
    //<i class="df-d20-3"></i>
    return i(["class" => g.name]);
  }
}
