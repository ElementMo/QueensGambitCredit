#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

uniform vec2 resolution;
uniform float intensity;
uniform float dist;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    vec4 col = texture2D(texture, uv);
    
    col = mix(col, vec4(0.0), pow(distance(uv, vec2(0.5, 0.5)), dist) * intensity);

    gl_FragColor = vec4(col);
}