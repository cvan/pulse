attribute float id;

varying float vID;
varying vec3 vDist;

const int size = @SIZE;
uniform vec3 touchers[ size ];

vec3 getClosestFinger( vec3 p , out vec3 fing){
  vec3 closestP = vec3(10000. );
  float closestD = 100000.;

	for( int i  = 0; i < size; i++ ){
    vec3 p2 = touchers[i];
    vec3 dif = p2 - p;
    float len = length( dif );
    if( len < closestD ){
      closestD = len;
      closestP = dif;
      fing = p2;
    }
	}

  return closestP;
}

void main(){
	
	vID = id;

  vec3 mPos = ( modelMatrix * vec4( position ,1.)).xyz;
  vec3 closestFing = vec3( 1000000. );
	vDist = getClosestFinger( mPos , closestFing);


  if( length( vDist ) < .05 ){

    mPos +=  vDist;// ) * .1;
    //mPos = closestFing;

  }
	gl_Position = projectionMatrix * viewMatrix * vec4( mPos , 1. );

}