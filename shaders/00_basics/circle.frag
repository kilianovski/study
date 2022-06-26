#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


vec2 center = vec2(0.3, 0.3);
float radius = 0.1;
float thickness = 0.02;

void main() {

    // float max_rad = 0.2;
    radius = sin(u_time/1.)+1.;
    radius = mod(radius, 20.)/10.;

    vec2 st = gl_FragCoord.xy/u_resolution;

    vec2 aspect_ratio = vec2(u_resolution.x/u_resolution.y, 1.);
    

    float scaling_factor = 1./(radius + thickness);
    vec2 st_scaled = (((st-center) *aspect_ratio* scaling_factor));

    float small_radius = radius * scaling_factor;

    vec2 st_polar = vec2(
        atan(st_scaled.y, st_scaled.x), 
        sqrt(pow(st_scaled.x, 2.) + pow(st_scaled.y, 2.))
    );

    float pct = step(small_radius, st_polar.y) - step(1., st_polar.y);


    vec3 colorA = vec3(1., 0., .0);
    vec3 colorB = vec3(.5, 0, .5);

    vec3 color = mix(colorA, colorB, st.y);
    color = vec3(1.);
    gl_FragColor = vec4(pct*color,1.0);
}
