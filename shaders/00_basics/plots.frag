// Author: Inigo Quiles
// Title: Expo

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.00000000012, pct, st.y) -
          smoothstep( pct, pct+0.00000000000000000000002, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    float y = pow(st.x,2.0);

    vec3 color = vec3(y);

    float pct = plot(st,y);
    color = pct*vec3(0.0,1.0,0.0);

    gl_FragColor = vec4(color,1.0);
}
