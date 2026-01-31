shader_type canvas_item;

uniform vec4 key_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float tolerance : hint_range(0.0, 1.0) = 0.1;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float dist = distance(color.rgb, key_color.rgb);
	if (dist < tolerance) {
		discard;
	}
	COLOR = color;
}
