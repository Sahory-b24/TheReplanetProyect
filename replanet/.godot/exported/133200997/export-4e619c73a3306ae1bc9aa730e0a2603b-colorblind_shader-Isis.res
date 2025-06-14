RSRC                    Shader            ��������                                                  resource_local_to_scene    resource_name    code    script        )   res://Shader/colorblind_shader-Isis.tres �          Shader          (  shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform int mode = 0;

void fragment() {
    vec4 px = texture(SCREEN_TEXTURE, SCREEN_UV);
    vec3 color = px.rgb;

    if (mode == 1) {
        // Protanomaly (Red-Weak)
        color = vec3(
            0.817 * color.r + 0.183 * color.g,
            0.333 * color.r + 0.667 * color.g,
            color.b
        );
    } else if (mode == 2) {
        // Deuteranomaly (Green-Weak)
        color = vec3(
            0.8 * color.r + 0.2 * color.g,
            0.258 * color.r + 0.742 * color.g,
            color.b
        );
    } else if (mode == 3) {
        // Tritanomaly (Blue-Weak)
        color = vec3(
            color.r,
            0.95 * color.g + 0.05 * color.b,
            0.433 * color.g + 0.567 * color.b
        );
    } else if (mode == 4) {
        // Protanopia (Red-Blind)
        color = vec3(
            0.566 * color.g + 0.434 * color.b,
            color.g,
            color.b
        );
    } else if (mode == 5) {
        // Deuteranopia (Green-Blind)
        color = vec3(
            color.r,
            0.558 * color.r + 0.442 * color.b,
            color.b
        );
    } else if (mode == 6) {
        // Tritanopia (Blue-Blind)
        color = vec3(
            color.r,
            color.g,
            0.95 * color.r + 0.05 * color.g
        );
    } else if (mode == 7) {
        // Achromatopsia (Monochromacy)
        float gray = dot(color, vec3(0.299, 0.587, 0.114));
        color = vec3(gray, gray, gray);
    } else if (mode == 8) {
        // Blue Cone Monochromacy
        float gray = dot(color, vec3(0.01775, 0.10945, 0.8726));
        color = vec3(gray, gray, gray);
    }

    COLOR = vec4(color, 1.0);
}

       RSRC