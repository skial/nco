package;

/**
 * ...
 * @author Skial Bainn
 */
class Main implements Klas {
	
	static function main() {
		var s = null;
		
		var s1 = s || 'hello world';
		
		trace( s1 );
		
		s = 'bye world';
		
		s1 = s || 'hello again world';
		
		trace( s1 );
		trace( 1, 2, s || 'failed', 3, 4 );
		
		trace( s || s1 || 'third' || 'final' );
		trace( false || false || true || false );
		trace( null || null || 'third' || 'final' );
		
		var s2 = null || null || 'silly';
		trace( s2 );
		var a = true;
		var b = false;
		trace( b || a );
	}
	
}