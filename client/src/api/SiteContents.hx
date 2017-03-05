package api;

using thx.Arrays;
import thx.schema.SchemaDSL.*;
import thx.schema.SimpleSchema;
import thx.schema.SimpleSchema.*;

class SiteContents {
  public var version: String;
  public var pages: Array<PageAbstract>;
  public var home: PageAbstract;
  public var glyphs: Array<Glyph>;
  public function new(version: String, pages: Array<PageAbstract>, glyphs: Array<Glyph>) {
    this.version = version;
    this.home = pages.extract(function(p) return p.name == "home");
    this.pages = pages;
    this.glyphs = glyphs;
  }

  public static function schema<E>(): Schema<E, SiteContents> return object(ap3(
    SiteContents.new,
    required("version", string(), function(x: SiteContents) return x.version),
    required("pages", array(PageAbstract.schema()), function(x: SiteContents) return x.pages),
    required("glyphs", array(Glyph.schema()), function(x: SiteContents) return x.glyphs)
  ));
}
