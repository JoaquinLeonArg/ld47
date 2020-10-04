shader_type canvas_item;

uniform float x;

void fragment() {
	vec2 pos = vec2(fract(x + UV.x), UV.y);
	COLOR = texture(TEXTURE, pos);
}