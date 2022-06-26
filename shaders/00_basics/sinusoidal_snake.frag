#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
#define B_THICKNESS 0.008
#define B_STEP 0.12
#define X_OFFSET 0.05
#define Y_OFFSET 0.05

vec3 getBackground(vec2 st){
    float x = mod(st.x+X_OFFSET, B_STEP);
    float y = mod(st.y+Y_OFFSET, B_STEP);

    float pct = 
           (x > B_STEP - B_THICKNESS) 
        && (x < B_STEP + B_THICKNESS) 
        && (y < B_STEP)

        || 
        (y > B_STEP - B_THICKNESS) 
         && (y < B_STEP + B_THICKNESS) 
         && (x < B_STEP)

        // ((st.y > B_STEP + B_THICKNESS) 
        // || (st.y < B_STEP - B_THICKNESS))
            ? 1. : 0.;

    vec3 background = (1.0 - pct)*vec3(0.) + pct * vec3(0.4078, 0.2078, 0.0039);

    return background;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 background = getBackground(
        vec2(
            st.x + u_time / 40., 
            st.y
        )
    );



    float y = (sin(st.x*20. + u_time*5.) + 2.) / 4.;
    // y = st.x;

    float pct = (step(y-.02, st.y))*(1.-step(y+0.02, st.y));

    pct *= 1.-step(0.6, st.x);

    vec3 color = (1.-pct)*background + pct * vec3(0., 1.,0.);
    gl_FragColor = vec4(color,1.0);
}
