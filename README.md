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

### Without Klas

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

## What the generated code looks like

Take the following, _trivial_, code:
	
```Haxe
package ;

class Main implements Klas {
	
	public static function main() {
		var a = null;
		var value = a || 'backup value';
		trace( value );
	}
	
}
```

The `main` static function gets converted by the build macro
to the following:
	
```Haxe
package ;

class Main implements Klas {
	
	public static function main() {
        var a = null;
        var value = (a == null) ? 'backup value' : a;
        trace(value);
	}
	
}
```

If you have a nested check, this time shown with a _**silly**_ example:
	
```Haxe
package ;

class Main implements Klas {
	
	public static function main() {
		var value = null || null || 'backup value';
		trace( value );
	}
	
}
```
The macro generates the following code:
	
```Haxe
package ;

class Main implements Klas {
	
	public static function main() {
        var value = ((null == null) ? null : null == null) ? 'backup value' : (null == null) ? null : null;
		trace(value);
	}
	
}
```

But, thanks to the compiler being smart, all the ugly gets filtered out, take
the generated JavaScript output as an example:
	
```JavaScript
(function (console) { "use strict";
var Klas = function() { };
var Main = function() { };
Main.main = function() {
	var value = "backup value";
	console.log(value);
};
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});

```

[Klas]: https://github.com/skial/klas/