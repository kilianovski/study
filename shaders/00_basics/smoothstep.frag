#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    vec3 color = vec3(0., 1., 0.);

    // float pct = smoothstep(0.5-0.02, 0.5, st.y);
    float pct = smoothstep(0.5-0.1, 0.5, st.y)-smoothstep(0.5, 0.5+0.1, st.y);

    pct = step(0.5-0.1, st.y) - step(0.5+0.1, st.y);
    color *= pct;

    gl_FragColor = vec4(color,1.0);
}
