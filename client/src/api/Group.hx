package api;

class Group {
  public var title(default, null): String;
  public var size(default, null): Int;
  public var glyphs(default, null): Array<Glyph>;
  public function new(title: String, size: Int, glyphs:  Array<Glyph>) {
    this.title = title;
    this.size = size;
    this.glyphs = glyphs;
  }
}
