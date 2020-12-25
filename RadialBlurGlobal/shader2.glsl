#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

uniform vec2 resolution;


void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy;

    gl_FragColor = vec4(0.2, 1.0, 1.0, 1.0);
}