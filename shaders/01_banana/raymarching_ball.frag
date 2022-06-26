#ifdef GL_ES
precision mediump float;
#endif

#define MAX_ITER 200
#define SURFACE_DIST 0.00001
#define MAX_DIST 1000.


uniform vec2 u_resolution;
uniform float u_time;

float sdSphere(vec3 p, vec4 sphere){
    return length(p - sphere.xyz) - sphere.w;
}

float sdCapsule(vec3 p, vec3 a, vec3 b, float r){
    vec3 pa = p-a;
    vec3 ba = b-a;

    float t = dot(pa, ba) / dot(ba,ba);

    t = clamp(t, 0.,1.);

    vec3 n = a + t*ba;

    float d = length(p - n);
    return d - r;
}

float GetDist(vec3 p){
    float sphere_dist = sdSphere(p, vec4(0., 1., 6., 1.));
    sphere_dist = min(
        sdSphere(p, vec4(0., 1., 3., .1)),
        sphere_dist
    );
    float yplane_dist = p.y;
    float d = min(yplane_dist, sphere_dist);

    float ct = u_time/1.;
    ct = 1.;

    vec3 capsuleA = vec3(1,1,1.) * sin(ct) + (ct);
    vec3 capsuleB = vec3(2.)* sin(u_time)*1.+(ct);

    d = min(
        d,
        sdCapsule(p, capsuleA, capsuleB, 1.)
    );
    return d;
}


float RayMarch(vec3 ro, vec3 rd) { 
    float d0 = 0.;
    for(int i = 0; i < MAX_ITER; i++){
        vec3 p = ro + d0*rd;
        float d = GetDist(p);
        d0 += d;

        if (d < SURFACE_DIST || d > MAX_DIST) break;
    }

    return d0;
}

vec3 GetNormal(vec3 p){
    float d = GetDist(p);
    vec2 h = vec2(0.001, 0);

    vec3 n = vec3(
        GetDist(p+h.xyy),
        GetDist(p+h.yxy),
        GetDist(p+h.yyx)
    ) - d;

    return normalize(n);
}

float GetLightning(vec3 p){
    vec3 light = vec3(30,30.,30);
    vec3 l = normalize(light - p);

    vec3 n = GetNormal(p);
    float dif = dot(n, l);

    float lightDist = RayMarch(p+SURFACE_DIST*6.*n, l);

    
    if (lightDist < length(p-light)) {
        dif *= 0.1;
    }

    return dif;
}


void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy/u_resolution;

    uv -= 0.5;
    uv.x *= u_resolution.x/u_resolution.y;

    float focal = 1.;
    vec3 ro = vec3(sin(u_time)*10., 10., cos(u_time)*10.);
    // vec3 ro = vec3(10.,10.,10.);
    vec3 lookat = vec3(0., 0., 1.);

    vec3 f = normalize(lookat - ro);
    vec3 r = cross(f, vec3(0,1,0.));
    vec3 u = cross(r, f);
    vec3 c = ro + focal*f;

    vec3 i = c + uv.x*r + uv.y*u;
    vec3 rd = normalize(i - ro);

    float d =  RayMarch(ro, rd);
    vec3 p = ro + d*rd;
    float co = GetLightning(p); 
    vec3 col = vec3(co);

    // Output to screen
    gl_FragColor = vec4(col,1.0);
}
