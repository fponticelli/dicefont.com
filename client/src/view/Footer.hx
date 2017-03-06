package view;

import doom.html.Html.*;

class Footer {
  public static function render() {
    return div(
      ["class" => "footer"],
      [
        div(
          ["class" => "disclaimer"],
          [
            a(["href" => "https://github.com/fponticelli/dicefont.com"], "website"),
            " and ",
            a(["href" => "https://github.com/fponticelli/dicefont"], "font"),
            " by ",
            a(["href" => "https://twitter.com/fponticelli"], "Franco Ponticelli"),
            " using ",
            a(["href" => "https://github.com/fponticelli/doom"], "doom"),
          ]
        )
      ]
    );
  }
}
