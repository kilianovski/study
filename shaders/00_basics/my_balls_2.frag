#ifdef GL_ES
precision mediump float;
#endif


uniform vec2 u_resolution;
uniform float u_time;


float GetDist(vec3 p) {
    float planeDist = p.y;
    return planeDist;
}



float GetDistRd(vec3 ro, vec3 rd, vec3 p){
    return length(cross(p - ro, rd)) / length(rd);
}


vec3 GetTrajectory(float time){
    return vec3(cos(time*2.),sin(time*1.), cos(time)*10.+3.);
}


void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy/u_resolution;

    uv -= 0.5;
    uv.x *= u_resolution.x/u_resolution.y;

    vec3 ro = vec3(0., 0., 0.);
    vec3 rd = vec3(uv, 1.);

    vec3 p = GetTrajectory(u_time);
    float d = GetDistRd(ro, rd, p);
    float r = 0.1;
    float base_pct = smoothstep(r, r-0.01, d);
    vec3 col = base_pct*vec3(0.0, 0.549, 1.0);

    for(int i = 1; i < 100; i++) {
        vec3 p = GetTrajectory(u_time-float(i)/100.);
        float d = GetDistRd(ro, rd, p);
        float pct = smoothstep(r, r-0.01, d);
        col += ( pct / ( float(i)/.3 ) ) * (1.-base_pct);
    }




    // Output to screen
    gl_FragColor = vec4(col,1.0);
}
