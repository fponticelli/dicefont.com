package api;

using thx.Arrays;
using thx.Ints;
using thx.Strings;

class Glyphs {
  public static function sortf(a: Glyph, b: Glyph)
    return switch [a.face, b.face] {
      case [Number(a), Number(b)]: a.compare(b);
      case [Number(_), Empty]: 1;
      case [Empty, Number(_)]: -1;
      case [Empty, Empty]: 0;
    };

  public static function group(glyphs: Array<Glyph>): Array<Group> {
    return groups.map(function(group) {
      var f = function(g: Glyph) {
        return g.name == "df-" + group.prefix || g.name.startsWith("df-" + group.prefix + "-");
      }
      var g = glyphs.filter(f).order(sortf);
      return new Group(group.name, group.size, g);
    });
  }

  static var groups = [
    { name: "d2", size: 36, prefix: "d2" },
    { name: "d4", size: 36, prefix: "d4" },
    { name: "d6", size: 36, prefix: "d6" },
    { name: "d8", size: 36, prefix: "d8" },
    { name: "d10", size: 36, prefix: "d10" },
    { name: "d12", size: 36, prefix: "d12" },
    { name: "d20", size: 36, prefix: "d20" },
    { name: "dots solid d6", size: 24, prefix: "solid-small-dot-d6" },
    { name: "dots d6", size: 24, prefix: "small-dot-d6" }
  ];
}
