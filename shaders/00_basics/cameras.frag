#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float GetDistLine(vec3 ro, vec3 rd, vec3 p){
    return length(cross(p - ro, rd)) / length(rd);
}

float to01(float a, float b, float x){
    return (x-a) / b;
}

vec3 offset = vec3(.1, .1,.1);

float DrawBall(vec3 ro, vec3 rd, vec3 p){
    float r = 0.1;
    float d = GetDistLine(ro, rd, p+offset);
    return smoothstep(r, r-0.001, d);
}


void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy/u_resolution;

    uv -= 0.5;
    uv.x *= u_resolution.x/u_resolution.y;


    float focal = 1.;

    vec3 ro = vec3(2.*sin(u_time), 2., 3.*cos(u_time));
    vec3 lookat = vec3(0.,0.,0.);

    vec3 f = normalize(lookat - ro);
    vec3 r = cross(f, vec3(0., 1., 0.));
    vec3 u = cross(f, r);

    vec3 center = ro + focal*f;
    vec3 i = center + uv.x*r + uv.y*u;
    
    vec3 rd = i - ro;

    float c = 0.;


    c += DrawBall(ro, rd, vec3(0.,0.,0.));
    c += DrawBall(ro, rd, vec3(0.,0.,1.));
    c += DrawBall(ro, rd, vec3(0.,1.,0.));
    c += DrawBall(ro, rd, vec3(0.,1.,1.));

    c += DrawBall(ro, rd, vec3(1.,0.,0.));
    c += DrawBall(ro, rd, vec3(1.,0.,1.));
    c += DrawBall(ro, rd, vec3(1.,1.,0.));
    c += DrawBall(ro, rd, vec3(1.,1.,1.));

    vec3 col = vec3(c);

    // Output to screen
    gl_FragColor = vec4(col,1.0);
}
