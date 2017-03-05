package api;

import thx.schema.SchemaF;
import thx.schema.SchemaDSL.*;
import thx.schema.SimpleSchema;
import thx.schema.SimpleSchema.*;

class Glyph {
  public var name(default, null): String;
  public var code(default, null): String;

  public function new(name: String, code: String) {
    this.name = name;
    this.code = code;
  }

  public function toString()
    return 'Glyph: $name ($code)';

  public static function schema<E>(): Schema<E, Glyph> return object(builder());
  public static function builder<E>(): ObjectBuilder<E, thx.Unit, Glyph> return ap2(
    Glyph.new,
    required("name", string(), function(x: Glyph) return x.name),
    required("code",  string(), function(x: Glyph) return x.code)
  );
}
