shader_type canvas_item;

uniform sampler2D mask;

void fragment() {
	vec4 colour = texture(TEXTURE, UV);
    colour.a *= texture(mask, UV).a;

    COLOR = colour;
}
