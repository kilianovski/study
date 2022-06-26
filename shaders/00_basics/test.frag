#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    vec2 sm = u_mouse/u_resolution;
    // gl_FragColor = vec4(0./,0.,0.0,1.0);

    float sin_coef = (sin(u_time) + 1.)*500. + 1.;
    // sin_coef = 50000.;
    float y = pow(st.x, 2.0) + sin(st.x*50.)/sin_coef;

    float pct = step(y - 0.01, st.y) * (1.-step(y + 0.01, st.y));

    vec3 color = (1.0 - pct)*vec3(0.) + pct * vec3(0., 1.0, 0.);
    gl_FragColor = vec4(color,1.0);
    // gl_FragColor = vec4(sm.x,sm.y,0.0,1.0);
	// gl_FragColor = vec4(st.x * abs(sin(u_time)),st.y * abs(cos(u_time) * 0.1),0.0,1.0);
}
