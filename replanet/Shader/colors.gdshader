shader_type canvas_item;

uniform vec4 target_color : source_color;
uniform float tolerance : hint_range(0.0, 1.0) = 0.15;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float avg = (tex_color.r + tex_color.g + tex_color.b) / 3.0;

    bool is_gray = abs(tex_color.r - avg) < tolerance &&
                   abs(tex_color.g - avg) < tolerance &&
                   abs(tex_color.b - avg) < tolerance;

    if (is_gray) {
        vec3 final_color = mix(tex_color.rgb, target_color.rgb, avg);
        tex_color.rgb = final_color;
    }

    COLOR = tex_color;
}
