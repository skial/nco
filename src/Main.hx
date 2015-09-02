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
	}
	
}