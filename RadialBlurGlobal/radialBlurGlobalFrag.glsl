#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

uniform vec2 resolution;
uniform vec2 mouse;

uniform int NUM_SAMPLES = 100;
uniform float rayLength = 0.1;
uniform float intensity = 0.4;


void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    vec2 ndc_mouse = mouse.xy / resolution.xy;
    
    float decay = 0.968;
    float exposure = 0.210;
    float weight = 0.587;

    vec2 tc = uv;
    vec2 deltaTexCoord = tc;
    deltaTexCoord = uv + ndc_mouse - 1.0;
    deltaTexCoord *= rayLength / float(NUM_SAMPLES);

    vec4 color = texture2D(texture, uv);
    float illuminationDecay = 1.0;
    
    for(int i=0; i<float(NUM_SAMPLES); i++) {
        tc -= deltaTexCoord;
        vec4 sampleTex = texture2D(texture, tc) * intensity;
        sampleTex *= illuminationDecay;
        color += sampleTex;
        illuminationDecay *= decay;
    }

    gl_FragColor = color * exposure;
}