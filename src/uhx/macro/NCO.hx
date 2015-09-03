package uhx.macro;

import haxe.macro.Printer;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.ds.StringMap;
import haxe.macro.Context;

using haxe.macro.Tools;
using haxe.macro.Context;

/**
 * ...
 * @author Skial Bainn
 */
class NCO {

	public static function initialize() {
		try {
			KlasImp.initialize();
			KlasImp.inlineMetadata.add( ~/.+\|\|.+/, NCO.handler );
			
		} catch (e:Dynamic) {
			// This assumes that `implements Klas` is not being used
			// but `@:autoBuild` or `@:build` metadata is being used 
			// with the provided `your.macro.Class.build()` method.
			
		}
	}
	
	private static var printer = new Printer();
	
	public static function build():Array<Field> {
		var cls = Context.getLocalClass().get();
		var fields = Context.getBuildFields();
		
		for (field in fields) field = handler( cls, field );
		
		return fields;
	}
	
	public static function handler(cls:ClassType, field:Field):Field {
		switch (field.kind) {
			case FFun(method) if (method.expr != null):
				method.expr.iter( process.bind( _, new StringMap() ) );
				trace( printer.printField( field ) );
				
			case _:
				
				
		}
		
		return field;
	}
	
	private static function process(expr:Expr, variables:StringMap<ComplexType>) {
		switch (expr) {
			case { expr:EVars(vars), pos:_ } :
				// Collect and store variable info
				for (v in vars) {
					if (!variables.exists( v.name )) {
						variables.set( v.name, v.type );
						
					} else if (variables.get( v.name ) == null) {
						variables.set( v.name, v.type );
						
					}
					
				}
				
				trace( [for (k in variables.keys()) k] );
				// Process variable expressions
				for (v in vars) if (v.expr != null) process( v.expr, variables );
				
			//case macro $name = $value /*if(variables.exists( printer.printExpr( name ) ))*/:
				//trace( name, value, Context.typeof( value ) );
				//value.iter( process.bind( _, variables ) );
				
			case macro $e1 || $e2 if (unify( e1, e2, variables )):
				trace( e1, e2 );
				
				e1.iter( process.bind( _, variables ) );
				e2.iter( process.bind( _, variables ) );
				expr.expr = (macro $e1 == null ? $e2 : $e1).expr;
				
			case _:
				trace( expr );
				expr.iter( process.bind( _, variables ) );
				
		}
	}
	
	private static function typeof(expr:Expr, variables:StringMap<ComplexType>):Null<ComplexType> {
		var result = null;
		
		try {
			result = Context.typeof( expr ).toComplexType();
			
		} catch (e:Dynamic) switch (expr.expr) {
			case EConst(CIdent( name )) if(variables.exists( name )):
				result = variables.get( name );
				
			case EConst(CString(_)):
				result = macro:String;
				
			case EConst(CInt(_)):
				result = macro:Int;
				
			case EConst(CFloat(_)):
				result = macro:Float;
				
			case EConst(CRegexp(_, _)):
				result = macro:EReg;
				
			case _:
				expr.iter( function(v) result = typeof.bind(_, variables)(v) );
				
		}
		
		return result == null ? macro:Null<Dynamic> : result;
	}
	
	private static function unify(expr1:Expr, expr2:Expr, variables:StringMap<ComplexType>):Bool {
		return typeof( expr1, variables ).toType().unify( typeof( expr2, variables ).toType() );
	}
	
}