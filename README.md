# nco

> Null coalescing operator

## What is it?

This little build macro brings null coalescing to Haxe, by using 
the logical OR operator, `||`.

## Installation

`haxelib git nco https://github.com/skial/nco.git`

And add `-lib nco` to your hxml file.

## Usage

You have two options, use NCO with [Klas] or not.

### With Klas

```Haxe
package ;

class Main implements Klas {
	
	public static function main() {
		var s = Sys.args()[0];
		var path = s || '/default/path/to/../';
	}
	
}
```

## Without Klas

```Haxe
package ;

@:autoBuild( uhx.macro.NCO.build() )
class Main {
	
	public static function main() {
		var s = Sys.args()[0];
		var path = s || '/default/path/to/../';
	}
	
}
```

[Klas]: https://github.com/skial/klas/