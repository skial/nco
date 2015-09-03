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
	}
	
}